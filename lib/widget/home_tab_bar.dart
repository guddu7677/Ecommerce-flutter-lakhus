import 'package:badges/badges.dart';
import 'package:ecommerce_app/model/cart_product_provider.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/home_tab_screens/all_screen.dart';
import 'package:ecommerce_app/service/category_service.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:ecommerce_app/service/product_list_service.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../screens/productDetails/product_details_page.dart';
import '../screens/search_screen.dart';
import '../service/cart_provider.dart';
import '../service/product_service.dart';

class HomeTabBarView extends StatefulWidget {
  const HomeTabBarView({Key? key}) : super(key: key);
  @override
  _HomeTabBarViewState createState() => _HomeTabBarViewState();
}

class _HomeTabBarViewState extends State<HomeTabBarView> {
  late PageController _pageController;
  int _currentIndex = 0;
  CategoryService categoryService = CategoryService();
  ProductService productService = ProductService();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);

    if (mounted) {
      categoryService.fetchCategoryData();
    }
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
    final double itemHeight = (MediaQuery.of(context).size.height);
    final double itemWidth = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<Cart>(context);
    Size size = MediaQuery.of(context).size;
    // final cartCount = cartProvider.cart.getCartItemCount();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "All Category",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: orangeColor),
        ),
        centerTitle: true,
        actions: [
          Consumer<Cart>(
            builder: (context, value, child) {
              return badges.Badge(
                position: BadgePosition.topEnd(top: 0, end: 3),
                badgeAnimation: const badges.BadgeAnimation.slide(),
                badgeContent: Text(
                  cartProvider.totalItemCount.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreenPage(),
                          ));
                    },
                    icon: const Icon(CupertinoIcons.cart)),
              );
            },
          ),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bell)),
          const SizedBox(
            width: 10.0,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.06,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ));
              },
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                    hintText: "Search on Tassel",
                    suffixIcon: Icon(
                      Icons.search,
                      color: orangeColor,
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: whiteColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: whiteColor))),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
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
                              fontSize: 16,
                              color: _currentIndex == 0
                                  ? purpleColor
                                  : Colors.grey[600],
                            ),
                          ),
                          Container(
                            width: 5,
                            height: 5,
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
                  FutureBuilder(
                    future: categoryService.fetchCategoryData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: categoryService.categoryListmodel.length,
                          itemBuilder: (context, index) {
                            int step = index + 1;
                            return GestureDetector(
                              onTap: () => _onTabChanged(step),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text(
                                      categoryService
                                          .categoryListmodel[index].name
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _currentIndex == step
                                            ? purpleColor
                                            : Colors.grey[600],
                                      ),
                                    ),
                                    Container(
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          color: _currentIndex == step
                                              ? purpleColor
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Text("Loading...");
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: categoryService.categoryListmodel.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return AllScreen();
              } else {
                int categoryIndex = index - 1;
                return FutureBuilder(
                  future: productService.fetchSliderProductListData(
                      categoryService.categoryListmodel[categoryIndex].id
                          .toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        itemCount:
                            productService.sliderProductListmodel.length + 1,
                        padding: const EdgeInsets.all(10.0),
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1.0,
                          childAspectRatio: itemWidth / itemHeight,
                        ),
                        itemBuilder: (context, index) {
                          var items = productService
                              .sliderProductListmodel[categoryIndex];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                      id: items.id.toString(),
                                    ),
                                  ));
                            },
                            child: SizedBox(
                              width: size.width * 0.48,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.48,
                                    height: size.height * 0.3,
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(productService
                                            .sliderProductListmodel[categoryIndex]
                                            .img
                                            .toString()),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      items.title.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.currency_rupee_rounded,
                                          size: 15,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          items.price.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Text(snapshot.error.toString());
                    }
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
