import 'dart:convert';

import 'package:amazon_clone/api_links.dart';
import 'package:amazon_clone/constants/error_handle.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class AuthService {
  signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  });
  signIn({
    required BuildContext context,
    required String email,
    required String password,
  });

  //? get user data based on token
  getUserData(BuildContext context);
}

class AuthServiceImp extends AuthService {
  @override
  signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserModel user = UserModel(
        id: '',
        name: name,
        email: email,
        password: password,
        type: '',
        token: '',
        address: '',
      );

      http.Response response = await http.post(
        Uri.parse(ApiLinks.signUp),
        body: jsonEncode(user.toJson()),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
      );

      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnakBar(
              context,
              'Account Created! Login with the same credentials!',
            );
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
  signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiLinks.signIn),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            if (context.mounted) {
              Provider.of<UserPorvider>(context, listen: false)
                  .setUser(jsonDecode(response.body));
              await pref.setString('token', jsonDecode(response.body)['token']);
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomeScreen.routeName,
                  (route) => false,
                );
              }
            }
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnakBar(context, e.toString());
      }
    }
  }

  //! get user data
  @override
  getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        prefs.setString('token', '');
      } else {
        var tokenRes = await http.post(
          Uri.parse(ApiLinks.vaildToken),
          headers: <String, String>{
            "Content-Type": "application/json",
            "token": token,
          },
        );
        var response = jsonDecode(tokenRes.body);
        if (response == true) {
          //? get user data
          http.Response response = await http.get(
            Uri.parse(ApiLinks.getUserData),
            headers: <String, String>{
              "Content-Type": "application/json",
              "token": token,
            },
          );
          if (context.mounted) {
            Provider.of<UserPorvider>(context, listen: false)
                .setUser(jsonDecode(response.body));
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnakBar(context, e.toString());
      }
    }
  }
}
