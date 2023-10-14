import 'package:ecommerce_app/screens/category/category_all.dart';
import 'package:ecommerce_app/screens/home_tab_screens/all_screen.dart';
import 'package:ecommerce_app/service/category_service.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryOnTapView extends StatefulWidget {
  String title;
  String titless;
  CategoryOnTapView({Key? key, required this.title, required this.titless})
      : super(key: key);

  @override
  _HomeTabBarViewState createState() => _HomeTabBarViewState();
}

class _HomeTabBarViewState extends State<CategoryOnTapView> {
  late PageController _pageController;
  int _currentIndex = 0;
  CategoryService categoryService = CategoryService();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          widget.titless,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: orangeColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.cart)),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bell)),
          const SizedBox(
            width: 10.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.06,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Search on Tassel",
                    suffixIcon: const Icon(CupertinoIcons.search),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: whiteColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: whiteColor))),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            CategoryAllView(id: widget.title),
          ],
        ),
      ),
    );
  }
}
