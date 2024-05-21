import 'dart:io';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../constants/utils.dart';
import '../services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = 'add_product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  //? controllers and form key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController produtNamecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  //? product categories
  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  String selectedCate = 'Mobiles';
  //? product images
  List<File> images = [];
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  //? product services
  final AdminServicesImp adminServices = AdminServicesImp();
  void sellProduct() async {
    if (formKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProducts(
        context: context,
        name: produtNamecontroller.text,
        description: descriptioncontroller.text,
        price: double.parse(pricecontroller.text),
        quantity: double.parse(quantitycontroller.text),
        category: selectedCate,
        images: images,
      );
    }
  }

  @override
  void dispose() {
    produtNamecontroller.dispose();
    descriptioncontroller.dispose();
    pricecontroller.dispose();
    quantitycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((imgUrl) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              imgUrl,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                          autoPlay: true,
                        ),
                      )
                    : InkWell(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          strokeCap: StrokeCap.round,
                          dashPattern: const [10, 4],
                          child: Container(
                            width: double.infinity,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Select Product Image',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 20),
                CustomTextField(
                  myController: produtNamecontroller,
                  hintText: 'Product Name',
                ),
                CustomTextField(
                  myController: descriptioncontroller,
                  hintText: 'Description',
                  maxLine: 7,
                ),
                CustomTextField(
                  myController: pricecontroller,
                  hintText: 'Product Price',
                ),
                CustomTextField(
                  myController: quantitycontroller,
                  hintText: 'Product Quantity',
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: selectedCate,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? newVal) {
                      setState(() {
                        selectedCate = newVal!;
                      });
                    },
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 15),
                CustomButton(
                  title: 'Sell',
                  onPressed: sellProduct,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
