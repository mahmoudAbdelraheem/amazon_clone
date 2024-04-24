import 'dart:convert';

import 'package:amazon_clone/api_links.dart';
import 'package:amazon_clone/constants/error_handle.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeServices {
  Future<List<ProductModel>> getProductByCategory({
    required BuildContext context,
    required String category,
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
}
