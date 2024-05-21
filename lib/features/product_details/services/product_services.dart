import 'dart:convert';

import '../../../api_links.dart';
import '../../../constants/error_handle.dart';
import '../../../constants/utils.dart';
import '../../../models/product_model.dart';
import '../../../models/user_model.dart';
import '../../../providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductDetailsServices {
  void ratingProduct({
    required BuildContext context,
    required ProductModel product,
    required double rating,
  });
  void addToCart({
    required BuildContext context,
    required ProductModel product,
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

  @override
  void addToCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    var userProvider = Provider.of<UserPorvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse(ApiLinks.addToCart),
        headers: <String, String>{
          "Content-Type": "application/json",
          "token": userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id': product.id,
          },
        ),
      );
      print('response for add to cart ${response.body}');
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            UserModel user = userProvider.user.copyWith(
              cart: jsonDecode(response.body)['cart'],
            );
            userProvider.setUserFromModel(user);
            showSnakBar(context, 'Product Added Successfuly to Cart.');
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
