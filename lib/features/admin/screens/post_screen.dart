import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/profile/widgets/single_product.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../services/admin_services.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  void navToAddProductScreen() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  //? admin services
  AdminServicesImp adminServices = AdminServicesImp();
  List<ProductModel>? products;

  getProduct() async {
    products = await adminServices.getProducts(context);
    setState(() {});
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: products!.length,
              itemBuilder: (context, index) {
                ProductModel productData = products![index];
                print("product data of index [$index]= ${productData.name}");
                print('image length  = ${productData.imagesUrl.length}');
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: productData.imagesUrl.isNotEmpty
                          ? SingleProduct(image: productData.imagesUrl[0])
                          : const Placeholder(), // Replace Placeholder with appropriate widget
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add A Product',
              onPressed: navToAddProductScreen,
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
