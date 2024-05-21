import 'dart:convert';

import '../../../api_links.dart';
import '../../../constants/error_handle.dart';
import '../../../constants/utils.dart';
import '../../../models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class SearchServices {
  Future<List<ProductModel>> searchProducts({
    required BuildContext context,
    required String searchQuary,
  });
}

class SearchServicesImp extends SearchServices {
  @override
  Future<List<ProductModel>> searchProducts({
    required BuildContext context,
    required String searchQuary,
  }) async {
    List<ProductModel> products = [];
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      http.Response response = await http.get(
        Uri.parse("${ApiLinks.searchProducts}/$searchQuary"),
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
