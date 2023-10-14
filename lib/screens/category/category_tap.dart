import 'package:ecommerce_app/screens/category/category_all.dart';
import 'package:ecommerce_app/screens/category/category_tap/category_product_view.dart';
import 'package:ecommerce_app/screens/home_tab_screens/all_screen.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryTapView extends StatefulWidget {
  String title;
  String titless;
  CategoryTapView({Key? key, required this.title, required this.titless})
      : super(key: key);

  @override
  _HomeTabBarViewState createState() => _HomeTabBarViewState();
}

class _HomeTabBarViewState extends State<CategoryTapView> {
  late PageController _pageController;
  int _currentIndex = 0;

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
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.cart)),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bell)),
          const SizedBox(
            width: 10.0,
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 5.0,
              ),
              Container(
                height: 0,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => _onTabChanged(0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              'All',
                              style: TextStyle(
                                fontSize: 0,
                                color: _currentIndex == 0
                                    ? purpleColor
                                    : Colors.grey[600],
                              ),
                            ),
                            Container(
                              width: 0,
                              height: 0,
                              decoration: BoxDecoration(
                                  color: _currentIndex == 0
                                      ? purpleColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onTabChanged,
                  children: [
                    CategoryProductView(
                      id: widget.title,
                      title: widget.titless,
                    ),
               
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
