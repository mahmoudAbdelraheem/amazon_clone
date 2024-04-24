import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/widget/address_box.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widgets/searched_product.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search_screen';
  final String searchQuary;
  const SearchScreen({super.key, required this.searchQuary});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel>? products;
  SearchServicesImp searchServices = SearchServicesImp();

  void searchProducts() async {
    products = await searchServices.searchProducts(
      context: context,
      searchQuary: widget.searchQuary,
    );
    setState(() {});
  }

  @override
  void initState() {
    searchProducts();
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void navToSearchScreen() async {
    if (searchController.text.isNotEmpty) {
      products = await searchServices.searchProducts(
        context: context,
        searchQuary: searchController.text,
      );
      setState(() {});
    } else {
      showSnakBar(context, 'You Need To Write Something To Search.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        helperStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        prefixIcon: InkWell(
                          onTap: () {
                            navToSearchScreen();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search_outlined,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      body: products == null
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (_, index) {
                      return SearchedProducts(product: products![index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
