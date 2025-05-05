import 'customer.dart';

class Order {
  final int id;
  final String? status;
  final Customer customer;
  final int orderTotal;
  final String paymentMethod;
  final DateTime orderDate;
  final String address;

  Order({
    required this.id,
    required this.status,
    required this.customer,
    required this.orderTotal,
    required this.paymentMethod,
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
      orderDate: DateTime.parse(json['order_date']),
      address: json['address'],
    );
  }
}
