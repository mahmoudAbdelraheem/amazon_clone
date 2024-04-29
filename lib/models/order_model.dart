// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazon_clone/models/product_model.dart';

class OrderModel {
  final String id;
  final List<ProductModel> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final double totalPrice;
  OrderModel({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderAt': orderedAt,
      'totalPrice': totalPrice,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['_id'] ?? '',
      products: List<ProductModel>.from(
        map['products']?.map(
          (e) => ProductModel.fromMap(e['product']),
        ),
      ),
      quantity: List<int>.from(
        map['products']?.map(
          (e) => e['quantity'],
        ),
      ),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderAt'] ?? 0,
      totalPrice: map['totalPrice']!.toDouble() ?? 0.0,
      status: map['status'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(Map<String, dynamic> map) =>
      OrderModel.fromMap(map);
}
