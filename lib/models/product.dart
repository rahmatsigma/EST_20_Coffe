// lib/models/product.dart

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final String? category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    this.category,
  });

  // Fungsi untuk mengubah JSON dari API menjadi Object Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      // Memastikan harga di-cast ke double dengan aman
      price: double.parse(json['price'].toString()),
      imageUrl: json['image_url'],
      category: json['category'],
    );
  }
}