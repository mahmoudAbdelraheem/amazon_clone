import 'package:amazon_clone/models/user_model.dart';
import 'package:flutter/material.dart';

class UserPorvider extends ChangeNotifier {
  UserModel _user = UserModel(
    name: '',
    password: '',
    email: '',
    address: '',
    id: '',
    token: '',
    type: '',
  );

  UserModel get user => _user;

  void setUser(Map<String, dynamic> userJson) {
    _user = UserModel.fromJson(userJson);
    notifyListeners();
  }
}