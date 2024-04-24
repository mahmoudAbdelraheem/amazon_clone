import 'dart:convert';

import 'package:amazon_clone/api_links.dart';
import 'package:amazon_clone/constants/error_handle.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductDetailsServices {
  void ratingProduct({
    required BuildContext context,
    required ProductModel product,
    required double rating,
  });
}

class ProductDetailsServicesImp extends ProductDetailsServices {
  @override
  void ratingProduct({
    required BuildContext context,
    required ProductModel product,
    required double rating,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    try {
      http.Response response = await http.post(
        Uri.parse(ApiLinks.ratingProduct),
        headers: <String, String>{
          "Content-Type": "application/json",
          "token": token!,
        },
        body: jsonEncode({
          'id': product.id,
          'rating': rating,
        }),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnakBar(context, 'Thankes For Rating...');
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnakBar(context, e.toString());
      }
    }
  }
}
