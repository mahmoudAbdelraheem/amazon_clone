import 'dart:convert';

import '../../../api_links.dart';
import '../../../constants/error_handle.dart';
import '../../../constants/utils.dart';
import '../../../models/user_model.dart';
import '../../../providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

abstract class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String userAddress,
  });

  void placeOrder({
    required BuildContext context,
    required String userAddress,
    required double totalSum,
  });
}

class AddressServicesImp extends AddressServices {
  @override
  void saveUserAddress({
    required BuildContext context,
    required String userAddress,
  }) async {
    final userProvider = Provider.of<UserPorvider>(context, listen: false);

    try {
      http.Response response = await http.post(
        Uri.parse(ApiLinks.addUserAddress),
        headers: <String, String>{
          "Content-Type": "application/json",
          "token": userProvider.user.token,
        },
        body: jsonEncode({
          'address': userAddress,
        }),
      );

      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            UserModel user = userProvider.user.copyWith(
              address: jsonDecode(response.body)['address'],
            );

            userProvider.setUserFromModel(user);
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
  void placeOrder({
    required BuildContext context,
    required String userAddress,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserPorvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse(ApiLinks.placeOrder),
        headers: <String, String>{
          "Content-Type": "application/json",
          "token": userProvider.user.token,
        },
        body: jsonEncode({
          'address': userAddress,
          'totalAmount': totalSum,
          'cart': userProvider.user.cart,
        }),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            UserModel user = userProvider.user.copyWith(
              cart: [],
            );
            userProvider.setUserFromModel(user);
            showSnakBar(context, 'Your order has been placed!');
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
