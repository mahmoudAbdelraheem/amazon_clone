import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/profile/widgets/single_product.dart';
import 'package:amazon_clone/models/order_model.dart';
import 'package:flutter/material.dart';

import '../../order_derails/screens/order_details_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final AdminServicesImp adminServices = AdminServicesImp();
  List<OrderModel>? orders;
  void getOrders() async {
    orders = await adminServices.getUsersOrders(context);
    setState(() {});
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  navToOrderDetailsScreen(OrderModel order) {
    Navigator.pushNamed(
      context,
      OrderDetailsScreen.routeName,
      arguments: order,
    );
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              itemCount: orders!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (_, index) {
                final orderData = orders![index];
                return InkWell(
                  onTap: () => navToOrderDetailsScreen(orderData),
                  child: SizedBox(
                    height: 140,
                    child: SingleProduct(
                      image: orderData.products[0].images[0],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
