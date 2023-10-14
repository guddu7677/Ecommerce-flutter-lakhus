import 'package:ecommerce_app/service/product_list_service.dart';
import 'package:ecommerce_app/service/profile_service.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:ecommerce_app/widget/home_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductService productService = ProductService();
  ProfileService profileService = ProfileService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileService.fetchProfileDetailsData();
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SizedBox(
          width: size.width,
          height: size.height,
          child: HomeTabBarView()),
    );
  }
}
