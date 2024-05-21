import 'dart:convert';

import '../../../api_links.dart';
import '../../../constants/error_handle.dart';
import '../../../constants/utils.dart';
import '../../auth/screens/auth_screen.dart';
import '../../../models/order_model.dart';
import '../../../providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileServices {
  Future<List<OrderModel>> getUserOrders({required BuildContext context});
  logOut({
    required BuildContext context,
  });
}

class ProfileServicesImp extends ProfileServices {
  @override
  Future<List<OrderModel>> getUserOrders(
      {required BuildContext context}) async {
    List<OrderModel> orders = [];
    final userProvider = Provider.of<UserPorvider>(context, listen: false);
    try {
      http.Response response = await http.get(
        Uri.parse(ApiLinks.getOrders),
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
            List<dynamic> responseData = jsonDecode(response.body);
            for (int i = 0; i < responseData.length; i++) {
              orders.add(OrderModel.fromJson(responseData[i]));
            }
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnakBar(context, e.toString());
      }
    }

    return orders;
  }

  @override
  logOut({required BuildContext context}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', '');
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AuthScreen.routeName,
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnakBar(context, e.toString());
      }
    }
  }
}
