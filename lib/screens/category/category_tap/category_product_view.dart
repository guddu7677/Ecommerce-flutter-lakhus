import 'package:ecommerce_app/screens/category/category_ontap_view.dart';
import 'package:ecommerce_app/screens/category/category_tap.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:ecommerce_app/service/product_list_service.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:ecommerce_app/widget/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../productDetails/product_details_page.dart';

class CategoryProductView extends StatefulWidget {
  String id;
  String title;
  CategoryProductView({super.key, required this.id, required this.title});

  @override
  State<CategoryProductView> createState() => _GridViewProductScreenState();
}

class _GridViewProductScreenState extends State<CategoryProductView> {
  ScrollController _scrollController = ScrollController();
  bool isScrollDown = false;
  bool isVisible = false;
  double previouseScrollPosition = 0;
  ProductService productService = ProductService();

  List title = [
    "Round Neck T-Shirt",
    "Casual Shirt",
    "Pool T-Shirt",
    "Jeans",
    "Suit & Blazer",
    "Sports Wear",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(scrollListener);
    productService.fetchFilterProductListData(widget.id);
  }

  void scrollListener() {
    if (_scrollController.position.pixels > previouseScrollPosition) {
      // Scrolling down
      if (!isVisible) {
        setState(() {
          isVisible = true;
        });
      }
    } else {
      if (_scrollController.position.userScrollDirection !=
              ScrollDirection.idle &&
          isVisible) {
        setState(() {
          isVisible = false;
        });
      }
    }

    previouseScrollPosition = _scrollController.position.pixels;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 30) / 2.1;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: productService.fetchFilterProductListData(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  controller: _scrollController,
                  itemCount: productService.subProductListmodel.length,
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
                    var items = productService.filterDataList[index];
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         CategoryTapView(title: title[index]),
                        //   ),
                        // );
                      },
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  id: items.id.toString(),
                                ),
                              ));
                        },
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
                                  image: NetworkImage(Config.baseApi +
                                      productService
                                          .subProductListmodel[index].img
                                          .toString()),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                items.title.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Text(snapshot.error.toString());
              }
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedOpacity(
                opacity: isVisible ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Center(
                  child: Container(
                    width: size.width * 0.38,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                      color: const Color(0xffE7E7E8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2.0,
                          blurStyle: BlurStyle.outer,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              showBottomSheet(
                                elevation: 4.0,
                                context: context,
                                builder: (context) {
                                  return FilterBottomSheet();
                                },
                              );
                            },
                            child: Container(
                              width: size.width * 0.17,
                              height: size.height * 0.07,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.filter_alt_outlined,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * 0.17,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.more_horiz_rounded,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              )
            ],
          )
        ],
      ),
    );
  }
}
