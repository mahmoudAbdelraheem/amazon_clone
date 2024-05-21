import '../../../common/widgets/defualt_app_bar.dart';
import '../../../constants/utils.dart';
import '../widget/address_box.dart';
import '../widget/carousel_images.dart';
import '../../search/screens/search_screen.dart';
import 'package:flutter/material.dart';

import '../widget/deal_of_day.dart';
import '../widget/top_categories.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void navToSearchScreen() {
    if (searchController.text.isNotEmpty) {
      Navigator.pushNamed(context, SearchScreen.routeName,
          arguments: searchController.text);
    } else {
      showSnakBar(context, 'You Need To Write Something To Search.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // todo test serch function in defualt app bar
      appBar: DefualtAppBar(
        searchController: searchController,
        navToSearchScreen: navToSearchScreen,
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddressBox(),
              TopCategories(),
              CarouselImages(),
              DealOfDay(),
            ],
          ),
        ),
      ),
    );
  }
}
