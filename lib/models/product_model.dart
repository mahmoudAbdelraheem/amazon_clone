import 'dart:convert';

class ProductModel {
  final String name;
  final String description;
  final double quantity;
  final List<String> imagesUrl;
  final String category;
  final double price;
  final String? id;

  ProductModel({
    required this.name,
    required this.description,
    required this.quantity,
    required this.imagesUrl,
    required this.category,
    required this.price,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': imagesUrl,
      'category': category,
      'price': price,
      'id': id,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      imagesUrl: List<String>.from(map['images'] ?? []),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> map) =>
      ProductModel.fromMap(map);

  String toJson() => json.encode(toMap());
}
