import 'package:flutter/material.dart';
import 'package:shop/models/order.dart';
import 'package:shop/services/api_service.dart';
import 'package:shop/route/screen_export.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> order = [];
  @override
  void initState() {
    super.initState();
    loadOrder();
  }

  void loadOrder() async {
    final result = await ApiService.getUserOrder();
    setState(() {
      order = result;
    });
  }

  List<Order> getFilteredOrders(String status) {
    return order.where((o) => o.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Đơn hàng', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [SizedBox(width: 48)], // Space for symmetry
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Box
            // TextField(
            //   decoration: InputDecoration(
            //     prefixIcon: const Icon(Icons.search, color: Colors.grey),
            //     suffixIcon: const Icon(Icons.tune, color: Colors.grey),
            //     hintText: 'Find an order...',
            //     filled: true,
            //     fillColor: const Color(0xFFF8F8F8),
            //     contentPadding: const EdgeInsets.symmetric(vertical: 15),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(15),
            //       borderSide: BorderSide.none,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 30),

            const Text("Lịch sử đơn hàng",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 15),

            OrderItem(
              icon: Icons.account_balance_wallet_outlined,
              label: 'Đang chờ xử lý',
              count: getFilteredOrders("PENDING").length,
              color: Colors.amber,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  orderDetailsScreenRoute,
                  arguments: "PENDING",
                );
              },
            ),
            OrderItem(
              icon: Icons.inventory_2_outlined,
              label: 'Đã xác nhận',
              count: getFilteredOrders("CONFIRMED").length,
              color: Colors.lightBlue,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  orderDetailsScreenRoute,
                  arguments: "CONFIRMED",
                );
              },
            ),
            OrderItem(
              icon: Icons.local_shipping_outlined,
              label: 'Đang vận chuyển',
              count: getFilteredOrders("SHIPPED").length,
              color: Colors.lightBlue,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  orderDetailsScreenRoute,
                  arguments: "SHIPPED",
                );
              },
            ),
            OrderItem(
              icon: Icons.shopping_cart_checkout_outlined,
              label: 'Đã vận chuyển',
              count: getFilteredOrders("DELIVERED").length,
              color: Colors.lightBlue,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  orderDetailsScreenRoute,
                  arguments: "DELIVERED",
                );
              },
            ),
            OrderItem(
              icon: Icons.cancel_outlined,
              label: 'Đã hủy',
              count: getFilteredOrders("CANCELLED").length,
              color: Colors.redAccent,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  orderDetailsScreenRoute,
                  arguments: "CANCELLED",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final Color color;
  final VoidCallback onPressed;

  const OrderItem({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            padding: EdgeInsets.zero, // Remove default padding
          ),
          child: ListTile(
            leading: Icon(icon, color: Colors.black),
            title: Text(label, style: const TextStyle(fontSize: 15)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    count.toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
