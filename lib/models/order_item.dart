import 'package:shop/models/order.dart';
import 'package:shop/models/product.dart';

class OrderDetailsItem {
  final int id;
  final Product product; // Chỉ 1 product
  final int productTotalMoney;
  final int quantity;

  OrderDetailsItem({
    required this.id,
    required this.product,
    required this.productTotalMoney,
    required this.quantity,
  });

  factory OrderDetailsItem.fromJson(Map<String, dynamic> json) {
    return OrderDetailsItem(
      id: json['id'],
      product: Product.fromJson(json['product']), // Là object, không phải List
      productTotalMoney: json['product_total_money'],
      quantity: json['quantity'],
    );
  }
}
