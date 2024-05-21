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

abstract class CartServices {
  void removeFromCart({
    required BuildContext context,
    required ProductModel product,
  });
}

class CartServicesImp extends CartServices {
  @override
  void removeFromCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    var userProvider = Provider.of<UserPorvider>(context, listen: false);
    try {
      http.Response response = await http.delete(
        Uri.parse("${ApiLinks.removeFromCart}/${product.id}"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "token": userProvider.user.token,
        },
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            UserModel user = userProvider.user.copyWith(
              cart: jsonDecode(response.body)['cart'],
            );
            userProvider.setUserFromModel(user);
            showSnakBar(context, 'Product Removed Successfuly.');
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
