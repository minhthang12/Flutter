class Product {
  final int id;
  final String productName;
  final int price;
  final String productDescription;
  final String pictures;
  final String size;
  final int categoryId;
  final int providerId;

  Product({
    required this.id,
    required this.productName,
    required this.price,
    required this.productDescription,
    required this.pictures,
    required this.size,
    required this.categoryId,
    required this.providerId,
  });
    @override
  String toString() {
    return 'Product(name: $productName, price: $price)';
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['productName'],
      price: json['price'],
      productDescription: json['productDescription'],
      pictures: json['pictures'],
      size: json['size'],
      categoryId: json['categoryId'],
      providerId: json['providerId'],
    );
  }
}
