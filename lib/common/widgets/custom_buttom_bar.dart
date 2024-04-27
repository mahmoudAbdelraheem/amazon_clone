import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/profile/screens/profile_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class CustomUserButtomBar extends StatefulWidget {
  static const routeName = 'actual_home';
  const CustomUserButtomBar({super.key});

  @override
  State<CustomUserButtomBar> createState() => _CustomUserButtomBarState();
}

class _CustomUserButtomBarState extends State<CustomUserButtomBar> {
  int _pageIndex = 0;
  final double buttomBarWidth = 42;
  final double buttomBarBorderWidth = 5;
  final List<Widget> pages = [
    const HomeScreen(),
    const ProfileScreen(),
    const Center(child: Text('Cart Page')),
  ];
  void updatePage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int userCartLen = context.watch<UserPorvider>().user.cart.length;
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //? home page
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
          //? profile page
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
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: '',
          ),
          //? cart page
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
              child: badges.Badge(
                badgeContent: Text(
                  userCartLen.toString(),
                  style: TextStyle(
                    color: userCartLen == 0 ? Colors.black : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                badgeStyle: const badges.BadgeStyle(
                  elevation: 0,
                  badgeColor: Colors.white,
                ),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
