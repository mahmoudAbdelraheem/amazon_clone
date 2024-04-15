import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserPorvider>(context).user;
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Text('welcom to Home Screen ${user.name}'),
      ),
    );
  }
}
