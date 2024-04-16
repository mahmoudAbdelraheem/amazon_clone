import 'package:amazon_clone/common/widgets/custom_buttom_bar.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case CustomButtomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CustomButtomBar(),
      );

    default:
      //? custom error
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('This Page Not Found!')),
        ),
      );
  }
}
