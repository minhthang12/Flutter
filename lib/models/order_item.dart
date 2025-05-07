import 'package:shop/models/order.dart';
import 'package:shop/models/product.dart';

class OrderDetailsItem {
  final int id;
  final Order order;
  final List<Product> product;  // List of products, assuming multiple products
  final int productTotalMoney;
  final int quantity;

  OrderDetailsItem({
    required this.id,
    required this.order,
    required this.product,
    required this.productTotalMoney,
    required this.quantity,
  });

  factory OrderDetailsItem.fromJson(Map<String, dynamic> json) {
    List<Product> productList = [];
    if (json['product'] is List) {
      productList = (json['product'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList();
    } else if (json['product'] is Map) {
      productList = [Product.fromJson(json['product'])];
    }

    return OrderDetailsItem(
      id: json['id'],
      order: Order.fromJson(json['order']),
      product: productList,  // Use the product list
      productTotalMoney: json['product_total_money'],
      quantity: json['quantity'],
    );
  }
}
