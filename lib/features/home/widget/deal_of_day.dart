import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

import '../services/home_services.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({
    super.key,
  });

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  //? get deal of the day
  HomeServicesImp homeServices = HomeServicesImp();
  ProductModel? product;

  void getDealOfTheDay() async {
    product = await homeServices.getDealOfTheDay(context: context);
    setState(() {});
  }

  @override
  void initState() {
    getDealOfTheDay();
    super.initState();
  }

  void navToProductDetails() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: product == null
          ? const Loader()
          : product!.name.isEmpty
              ? const SizedBox()
              : InkWell(
                  onTap: navToProductDetails,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Deal Of Day',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Image.network(
                        product!.images[0],
                        height: 235,
                        fit: BoxFit.fitHeight,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          '\$${product!.price}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 5, left: 15, right: 40),
                        alignment: Alignment.topLeft,
                        child: Text(
                          product!.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      //? other images for the same product
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images
                              .map(
                                (url) => Image.network(
                                  url,
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15)
                            .copyWith(left: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'See All Deals',
                          style: TextStyle(
                            color: Colors.cyan[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
