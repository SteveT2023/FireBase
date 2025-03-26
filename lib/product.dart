class Product {
  final String id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  // Convert a Product object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  // Create a Product object from a Firestore Map
  factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: documentId,
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }
}
