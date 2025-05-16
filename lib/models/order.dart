import 'package:shop/models/customer.dart';
import 'package:shop/models/order_item.dart';

class Order {
  final int id;
  final String? status;
  final Customer customer;
  final int orderTotal;
  final String paymentMethod;
  final List<OrderDetailsItem> orderDetailsItems;
  final DateTime orderDate;
  final String address;

  Order({
    required this.id,
    required this.status,
    required this.customer,
    required this.orderTotal,
    required this.paymentMethod,
    required this.orderDetailsItems,
    required this.orderDate,
    required this.address,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      status: json['status'],
      customer: Customer.fromJson(json['customer']),
      orderTotal: json['order_total'],
      paymentMethod: json['payment_Method'],
      orderDetailsItems: (json['orderDetails'] as List)
          .map((item) => OrderDetailsItem.fromJson(item))
          .toList(),
      orderDate: DateTime.parse(json['order_date']),
      address: json['address'],
    );
  }
}
