import 'package:ecommerce_app/screens/home_tab_screens/grid_view/all_grid_view.dart';
import 'package:ecommerce_app/screens/productDetails/product_details_page.dart';
import 'package:ecommerce_app/service/product_list_service.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/material.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  List images = [
    "assets/placeholder3.png",
    "assets/placeholder2.png",
    "assets/cwest.png",
  ];
  ProductService productService = ProductService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productService.fetchTrendingProductListData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: size.width * 0.95,
                height: size.width * 0.5,
                decoration: BoxDecoration(
                    color: purpleColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8.0,
                    ),
                    Transform.rotate(
                        angle: -3.14 / 2,
                        child: const Text(
                          "    Top\nTrending",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        )),
                    const SizedBox(
                      width: 18.0,
                    ),
                    Image.asset(
                        "assets/clothing-rack-with-hawaiian-shirts-with-floral-print (1) 1.png")
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            FutureBuilder(
              future: productService.fetchTrendingProductListData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: size.height * 0.4,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      physics: const ScrollPhysics(),
                      itemCount: productService.trendingProductListmodel
                          .length, // Replace with your actual item count
                      itemBuilder: (BuildContext context, int index) {
                        var item =
                            productService.trendingProductListmodel[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                    id: item.id.toString(),
                                  ),
                                ));
                          },
                          child: SizedBox(
                            width: size.width *
                                0.45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width *
                                      0.45, // Adjust the width as per your requirements
                                  height: size.height * 0.3,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(item.img.toString()))),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SizedBox(
                                    width: size.width*.45,
                                    child: Text(
                                      item.title.toString(),
                                      maxLines: 1,

                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee_rounded,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "000",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Icon(
                                        Icons.currency_rupee_rounded,
                                        size: 15,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        "000",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: orangeColor,
                    ),
                  );
                } else {
                  return Text(snapshot.error.toString());
                }
              },
            ),
            Center(
              child: Container(
                width: size.width * 0.95,
                height: size.width * 0.5,
                decoration: BoxDecoration(
                    color: const Color(0xffFADCDE),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                            "assets/View of hawaiian shirts with floral print.png"),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 18.0,
                            ),
                            Text(
                              "Latest\nDesign",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5F1E22)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 18.0,
                    ),
                  ],
                ),
              ),
            ),
            GridViewProductScreen()
          ],
        ),
      ),
    );
  }
}
