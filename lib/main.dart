import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserPorvider()),
      ],
      child: const AmazonClone(),
    ),
  );
}

class AmazonClone extends StatefulWidget {
  const AmazonClone({super.key});

  @override
  State<AmazonClone> createState() => _AmazonCloneState();
}

class _AmazonCloneState extends State<AmazonClone> {
  AuthServiceImp authService = AuthServiceImp();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        useMaterial3: false,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserPorvider>(context).user.token.isNotEmpty
          ? const HomeScreen()
          : const AuthScreen(),
    );
  }
}

//todo change user model to final 
