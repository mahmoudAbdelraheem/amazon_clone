import '../../../common/widgets/loader.dart';
import 'add_product_screen.dart';
import '../../profile/widgets/single_product.dart';
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

  deleteProduct(String productId, int index) async {
    await adminServices.deleteProduct(
        context: context,
        id: productId,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
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
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: productData.images.isNotEmpty
                          ? SingleProduct(image: productData.images[0])
                          : const Placeholder(), // Replace Placeholder with appropriate widget
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
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
                            onPressed: () {
                              deleteProduct(productData.id!, index);
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                            ),
                          ),
                        ],
                      ),
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
