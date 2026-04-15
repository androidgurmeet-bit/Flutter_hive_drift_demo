class Product {
  final int id;
  final String name;
  final double price;
  final String productUrl;
  final int quantity;
  final String? description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.productUrl,
    required this.quantity,
    this.description,
  });
}