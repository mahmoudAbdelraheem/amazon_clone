import 'common/widgets/custom_buttom_bar.dart';
import 'features/address/screens/address_screen.dart';
import 'features/admin/screens/add_product_screen.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/home/screens/category_deals_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'features/order_derails/screens/order_details_screen.dart';
import 'features/product_details/screens/product_details_screen.dart';
import 'features/search/screens/search_screen.dart';
import 'models/order_model.dart';
import 'package:flutter/material.dart';

import 'models/product_model.dart';

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
    case CustomUserButtomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CustomUserButtomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case CategoryDealsScreen.routeName:
      String category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(category: category),
      );
    //? search screen
    case SearchScreen.routeName:
      String searchQuary = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuary: searchQuary),
      );
    //? Product details screen
    case ProductDetailsScreen.routeName:
      ProductModel product = routeSettings.arguments as ProductModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(product: product),
      );
    //? user Address screen
    case AddressScreen.routeName:
      String totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(totalAmount: totalAmount),
      );
    //? user order details
    case OrderDetailsScreen.routeName:
      OrderModel order = routeSettings.arguments as OrderModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailsScreen(order: order),
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
