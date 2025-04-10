import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Orders', style: TextStyle(color: Colors.black)),
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
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: const Icon(Icons.tune, color: Colors.grey),
                hintText: 'Find an order...',
                filled: true,
                fillColor: const Color(0xFFF8F8F8),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),

            const Text("Orders history", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 15),

            OrderItem(
              icon: Icons.account_balance_wallet_outlined,
              label: 'Awaiting Payment',
              count: 0,
              color: Colors.amber,
            ),
            OrderItem(
              icon: Icons.inventory_2_outlined,
              label: 'Processing',
              count: 1,
              color: Colors.lightBlue,
            ),
            OrderItem(
              icon: Icons.local_shipping_outlined,
              label: 'Delivered',
              count: 5,
              color: Colors.lightBlue,
            ),
            OrderItem(
              icon: Icons.shopping_cart_checkout_outlined,
              label: 'Returned',
              count: 3,
              color: Colors.lightBlue,
            ),
            OrderItem(
              icon: Icons.cancel_outlined,
              label: 'Canceled',
              count: 2,
              color: Colors.redAccent,
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

  const OrderItem({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(label, style: const TextStyle(fontSize: 15)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (count > 0 || label == 'Awaiting Payment')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    count.toString(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              const SizedBox(width: 10),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
