import 'package:amazon_clone/features/admin/screens/analytics_screen.dart';
import 'package:amazon_clone/features/admin/screens/orders_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import 'post_screen.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = 'admain_screen';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _pageIndex = 0;
  final double buttomBarWidth = 42;
  final double buttomBarBorderWidth = 5;
  final List<Widget> pages = [
    const PostScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
  ];
  void updatePage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  GlobalVariables.appLogo,
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Admin',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //? Post Orders
          BottomNavigationBarItem(
            icon: Container(
              width: buttomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _pageIndex == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: buttomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          //? analytics
          BottomNavigationBarItem(
            icon: Container(
              width: buttomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _pageIndex == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: buttomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.analytics_outlined),
            ),
            label: '',
          ),

          //? orders
          BottomNavigationBarItem(
            icon: Container(
              width: buttomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _pageIndex == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: buttomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.all_inbox_outlined),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
