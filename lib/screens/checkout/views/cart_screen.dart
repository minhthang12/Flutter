import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text("Cart"),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Review your order", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildCartItem(
                imageUrl: 'https://i.imgur.com/tXyOMMG.png',
                title: 'Sleeveless Tiered Dobby...',
                brand: 'WINTER HUDDI',
                price: '\$299,43',
                oldPrice: '\$534,33',
              ),
              const SizedBox(height: 12),
              _buildCartItem(
                imageUrl: 'https://i.imgur.com/tXyOMMG.png',
                title: 'Printed Sleeveless Tiered...',
                brand: 'WINTER HUDDI',
                price: '\$299,43',
                oldPrice: '\$534,33',
              ),
              const SizedBox(height: 24),
              const Text("Your Coupon code", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.confirmation_num, color: Colors.grey.shade400),
                  hintText: 'Type coupon code',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildOrderSummary(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Checkout", style: TextStyle(fontSize: 16)),
                ),
              )
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
  }) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(imageUrl, width: 70, height: 70, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(brand, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(price, style: const TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(
                    oldPrice,
                    style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
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
          const Text("Order Summary", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _summaryRow("Subtotal", "\$24"),
          _summaryRow("Shipping Fee", "Free", highlight: true),
          const Divider(height: 24),
          _summaryRow("Total (Include of VAT)", "\$25", bold: true),
          _summaryRow("Estimated VAT", "\$1"),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool highlight = false, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(
            value,
            style: TextStyle(
              color: highlight ? Colors.green : (bold ? Colors.black : Colors.grey[800]),
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}