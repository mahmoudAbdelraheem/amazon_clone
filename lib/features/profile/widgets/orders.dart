import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/order_derails/screens/order_details_screen.dart';
import 'package:amazon_clone/features/profile/services/profile_services.dart';
import 'package:amazon_clone/features/profile/widgets/single_product.dart';
import 'package:amazon_clone/models/order_model.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<OrderModel>? orders;

  final ProfileServicesImp profileServices = ProfileServicesImp();

  void getOrders() async {
    orders = await profileServices.getUserOrders(context: context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  navToOrderDetailsScreen(OrderModel order) {
    Navigator.pushNamed(context, OrderDetailsScreen.routeName,
        arguments: order);
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : orders!.isEmpty
            ? const Center(
                child: Text(
                  'You Don\'t order any thing yet!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Text(
                          'Your Order',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 14,
                            color: GlobalVariables.selectedNavBarColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //?display orders
                  Container(
                    height: 120,
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 20,
                      right: 0,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orders!.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () => navToOrderDetailsScreen(orders![index]),
                          child: SingleProduct(
                            image: orders![index].products[0].images[0],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
  }
}
