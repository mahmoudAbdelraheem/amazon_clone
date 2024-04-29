import 'dart:convert';

import 'package:amazon_clone/api_links.dart';
import 'package:amazon_clone/constants/error_handle.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/order_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

abstract class ProfileServices {
  Future<List<OrderModel>> getUserOrders({required BuildContext context});
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
      print('user id = ${userProvider.user.id}');
      print('orders json = ${response.body}');
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
}
