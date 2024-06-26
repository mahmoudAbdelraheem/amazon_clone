import 'dart:convert';

import '../../../api_links.dart';
import '../../../constants/error_handle.dart';
import '../../../constants/utils.dart';
import '../../../models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeServices {
  Future<List<ProductModel>> getProductByCategory({
    required BuildContext context,
    required String category,
  });
  Future<ProductModel> getDealOfTheDay({
    required BuildContext context,
  });
}

class HomeServicesImp extends HomeServices {
  @override
  Future<List<ProductModel>> getProductByCategory({
    required BuildContext context,
    required String category,
  }) async {
    List<ProductModel> products = [];
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      http.Response response = await http.get(
        Uri.parse("${ApiLinks.getProductsByCategory}?category=$category"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "token": token!,
        },
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            List<dynamic> responseData = jsonDecode(response.body);
            for (int i = 0; i < responseData.length; i++) {
              products.add(ProductModel.fromJson(responseData[i]));
            }
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnakBar(context, e.toString());
      }
    }
    return products;
  }

  @override
  Future<ProductModel> getDealOfTheDay({required BuildContext context}) async {
    ProductModel product = ProductModel(
      name: '',
      description: '',
      quantity: 0.0,
      images: [],
      category: '',
      price: 0.0,
    );

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      http.Response response = await http.get(
        Uri.parse(ApiLinks.dealOfDay),
        headers: <String, String>{
          "Content-Type": "application/json",
          "token": token!,
        },
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            var responseData = jsonDecode(response.body);
            product = ProductModel.fromJson(responseData);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnakBar(context, e.toString());
      }
    }

    return product;
  }
}
