import 'package:ecommerce_app/screens/add_cart.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/category_page.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/order_history.dart';
import 'package:ecommerce_app/screens/profile_screen.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavBarViews extends StatefulWidget {
  const BottomNavBarViews({super.key});

  @override
  State<BottomNavBarViews> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarViews> {
  late PersistentTabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PersistentTabController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView(
      context,
      backgroundColor: Colors.white,
      navBarHeight: 60,
      navBarStyle: NavBarStyle.simple,
      screens: const [
        HomePage(),
        CategoryPage(),
        OrderHistoryScreen(),
        AddtoCart(),
        ProfileScreen(),
      ],
      controller: controller,
      hideNavigationBarWhenKeyboardShows: true,
      resizeToAvoidBottomInset: true,
      items: [
        PersistentBottomNavBarItem(
            title: "Home",
            textStyle: TextStyle(fontSize: 10),
            icon: Icon(Icons.home_outlined),
            activeColorPrimary: orangeColor,
            inactiveColorPrimary: Colors.grey,
            iconSize: 25.0),
        PersistentBottomNavBarItem(
            title: "Category",
            textStyle: TextStyle(fontSize: 10),
            icon: Icon(Icons.category_outlined),
            activeColorPrimary: orangeColor,
            inactiveColorPrimary: Colors.grey,
            iconSize: 25.0),
        PersistentBottomNavBarItem(
            title: "Order History",
            textStyle: TextStyle(fontSize: 10),
            icon: Icon(Icons.storefront_sharp),
            activeColorPrimary: orangeColor,
            inactiveColorPrimary: Colors.grey,
            iconSize: 25.0),
        PersistentBottomNavBarItem(
            title: "Add to cart",
            textStyle: TextStyle(fontSize: 10),
            icon: Icon(CupertinoIcons.cart),
            activeColorPrimary: orangeColor,
            inactiveColorPrimary: Colors.grey,
            iconSize: 25.0),
        PersistentBottomNavBarItem(
            title: "Profile",
            textStyle: TextStyle(fontSize: 10),
            icon: Icon(CupertinoIcons.person),
            activeColorPrimary: orangeColor,
            inactiveColorPrimary: Colors.grey,
            iconSize: 25.0),
      ],
    ));
  }
}
