import 'package:flutter/material.dart';

class OnSaleScreen extends StatelessWidget {
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Sale'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          saleItem(
            image: 'https://via.placeholder.com/150',
            title: 'Product 1',
            oldPrice: 59.99,
            newPrice: 39.99,
          ),
          saleItem(
            image: 'https://via.placeholder.com/150',
            title: 'Product 2',
            oldPrice: 99.99,
            newPrice: 69.99,
          ),
          saleItem(
            image: 'https://via.placeholder.com/150',
            title: 'Product 3',
            oldPrice: 129.99,
            newPrice: 89.99,
          ),
        ],
      ),
    );
  }

  Widget saleItem({
    required String image,
    required String title,
    required double oldPrice,
    required double newPrice,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.network(image, width: 60, height: 60, fit: BoxFit.cover),
        title: Text(title),
        subtitle: Text(
          'Was \$${oldPrice.toStringAsFixed(2)}\nNow \$${newPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}
