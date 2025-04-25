import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_response.dart';
import 'package:shop/services/api_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartResponse? cart;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  void loadCart() async {
    final result = await ApiService.fetchCart();
    try {
      setState(() {
        cart = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateTotalCost() {
    if (cart != null) {
      double newTotal = 0;
      for (var item in cart!.cartItemDTOList) {
        newTotal += item.product.price * item.quantity;
      }
      setState(() {
        cart = CartResponse(
          cartItemDTOList: cart!.cartItemDTOList,
          totalCost: newTotal,
        );
      });
    }
  }

  void increaseQuantity(CartItem item) async {
    await ApiService.cartUpdateIncrease(item.product.id);
    setState(() {
      item.quantity += 1;
    });
    updateTotalCost();
  }

  void decreaseQuantity(CartItem item) async {
    await ApiService.cartUpdateDecrease(item.product.id);
    setState(() {
      if (item.quantity > 1) {
        item.quantity -= 1;
      }
    });
    updateTotalCost();
  }

  void removeItem(CartItem item) async {
    await ApiService.cartDeleteItem(item.id);
    setState(() {
      cart?.cartItemDTOList.remove(item);
    });
    updateTotalCost();
  }

  void createOrder() async {
    if(cart == null || cart!.cartItemDTOList.isEmpty) {
      print("Cart is empty");
      return;
    }
    final response = await ApiService.createOrder(cart!, addressController.text, selectedPaymentMethod);
    if (response.statusCode == 201) {
      print("Order created successfully!");
    } else {
      print("Failed to create order: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => {},
        // ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cart == null
              ? const Center(child: Text("Failed to load cart"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Review your order",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        ...cart!.cartItemDTOList.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildCartItem(
                                item: item,
                                imageUrl: item.product.pictures,
                                title: item.product.productName,
                                brand: item.product.size,
                                price:
                                    "\$${item.product.price.toStringAsFixed(2)}",
                                oldPrice: "",
                              ),
                            )),
                        const SizedBox(height: 24),
                        _buildAddressSection(),
                        _buildPaymentMethodSection(),
                        _buildOrderSummary(),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              createOrder();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text("Checkout",
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildCartItem({
    required String imageUrl,
    required String title,
    required String brand,
    required String price,
    required String oldPrice,
    required CartItem item,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child:
              Image.network(imageUrl, width: 70, height: 70, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(brand,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(price,
                      style: const TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  if (oldPrice.isNotEmpty)
                    Text(
                      oldPrice,
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: () => decreaseQuantity(item),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text("${item.quantity}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () => increaseQuantity(item),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => removeItem(item),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Order Summary",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _summaryRow(
              "Subtotal", "\$${cart?.totalCost.toStringAsFixed(2) ?? "0.00"}"),
          _summaryRow("Shipping Fee", "Free", highlight: true),
          const Divider(height: 24),
          _summaryRow("Total (Include of VAT)",
              "\$${cart?.totalCost.toStringAsFixed(2) ?? "0.00"}",
              bold: true),
          // _summaryRow("Estimated VAT", "\$1"),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value,
      {bool highlight = false, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(
            value,
            style: TextStyle(
              color: highlight
                  ? Colors.green
                  : (bold ? Colors.black : Colors.grey[800]),
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

TextEditingController addressController =
    TextEditingController(text: "123 Nguyễn Văn Cừ, Quận 5, TP.HCM");
String selectedPaymentMethod = "Credit Card";
final List<String> paymentMethods = [
  "Credit Card",
  "Cash on Delivery",
  "Momo",
  "ZaloPay",
];
Widget _buildAddressSection() {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Delivery Address",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: addressController,
          decoration: InputDecoration(
            hintText: "Enter your delivery address",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPaymentMethodSection() {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Payment Method",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedPaymentMethod,
          items: paymentMethods
              .map((method) => DropdownMenuItem(
                    value: method,
                    child: Text(method),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              // setState(() {
              selectedPaymentMethod = value;
              // });
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ],
    ),
  );
}
