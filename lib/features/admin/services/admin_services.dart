import 'dart:convert';
import 'dart:io';

import '../../../api_links.dart';
import '../../../constants/error_handle.dart';
import '../../../constants/utils.dart';
import '../models/sales.dart';
import '../../../models/order_model.dart';
import '../../../models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/screens/auth_screen.dart';

abstract class AdminServices {
  //? add product to db
  sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  });

  //? get all products
  Future<List<ProductModel>> getProducts(BuildContext context);

  //? delete product by id
  deleteProduct({
    required BuildContext context,
    required String id,
    required VoidCallback onSuccess,
  });
  //? get all users orders
  Future<List<OrderModel>> getUsersOrders(BuildContext context);
  //? change order status
  void changeOrderStatus({
    required BuildContext context,
    required OrderModel order,
    required int currentStatus,
    required VoidCallback onSuccess,
  });

  Future<Map<String, dynamic>> getAnalytics(BuildContext context);
  logOut({
    required BuildContext context,
  });
}

class AdminServicesImp extends AdminServices {
  @override
  sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      var token = pref.getString('token');
      final cloudinary = CloudinaryPublic('dbortkp5g', 'm34gp3bn');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );
      //? send data
      var response = await http.post(
        Uri.parse(ApiLinks.addProduct),
        headers: <String, String>{
          "Content-Type": "application/json",
          "token": token!,
        },
        body: product.toJson(),
      );

      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnakBar(context, "Product Added Successfly.");
            Navigator.pop(context);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnakBar(
          context,
          e.toString(),
        );
      }
    }
  }

  @override
  Future<List<ProductModel>> getProducts(BuildContext context) async {
    List<ProductModel> products = [];
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString('token');
      var response = await http.get(
        Uri.parse(ApiLinks.getProducts),
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
  deleteProduct({
    required BuildContext context,
    required String id,
    required VoidCallback onSuccess,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString('token');
      var response = await http.post(
        Uri.parse(ApiLinks.deleteProduct),
        headers: <String, String>{
          "Content-Type": "application/json",
          "token": token!,
        },
        body: jsonEncode({'id': id}),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            onSuccess();
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
  Future<List<OrderModel>> getUsersOrders(BuildContext context) async {
    List<OrderModel> orders = [];
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString('token');
      var response = await http.get(
        Uri.parse(ApiLinks.getAllUserOrders),
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
  void changeOrderStatus({
    required BuildContext context,
    required OrderModel order,
    required int currentStatus,
    required VoidCallback onSuccess,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString('token');
      var response = await http.post(
        Uri.parse(ApiLinks.changeOrderStatus),
        headers: <String, String>{
          "Content-Type": "application/json",
          "token": token!,
        },
        body: jsonEncode({
          'orderId': order.id,
          'currentStatus': currentStatus,
        }),
      );

      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            onSuccess();
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
  Future<Map<String, dynamic>> getAnalytics(BuildContext context) async {
    List<Sales> sales = [];
    int totalEaring = 0;
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString('token');
      var response = await http.get(
        Uri.parse(ApiLinks.getAnalyticsEarings),
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
            totalEaring = responseData['totalEarning'];
            sales = [
              Sales('Mobiles', responseData['mobileEarning']),
              Sales('Essentials', responseData['essentialsEarning']),
              Sales('Appliances', responseData['appliancesEarning']),
              Sales('Books', responseData['booksEarning']),
              Sales('Fashion', responseData['fashionEarning']),
            ];
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnakBar(context, e.toString());
      }
    }
    return {
      'sales': sales,
      'totalEaring': totalEaring,
    };
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
