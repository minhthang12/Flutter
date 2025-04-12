import 'package:shop/models/cart.dart';

class CartResponse {
  final List<CartItem> cartItemDTOList;
  double totalCost;

  CartResponse({
    required this.cartItemDTOList,
    required this.totalCost,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      cartItemDTOList: (json['cartItemDTOList'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      totalCost: (json['totalCost'] as num).toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'cartItemDTOList':
            cartItemDTOList.map((item) => item.toJson()).toList(),
        'totalCost': totalCost,
      };
}
