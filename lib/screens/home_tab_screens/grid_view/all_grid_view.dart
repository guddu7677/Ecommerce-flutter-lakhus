import 'package:ecommerce_app/screens/productDetails/product_details_page.dart';
import 'package:ecommerce_app/service/product_list_service.dart';
import 'package:flutter/material.dart';

class GridViewProductScreen extends StatefulWidget {
  const GridViewProductScreen({super.key});

  @override
  State<GridViewProductScreen> createState() => _GridViewProductScreenState();
}

class _GridViewProductScreenState extends State<GridViewProductScreen> {
  ProductService productService = ProductService();
  List images = [
    "assets/placeholder.png",
    "assets/placeholder1.png",
    "assets/cwest.png"
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productService.fetchProductListData();
  }

  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 30) / 2.1;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: productService.fetchProductListData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            child: GridView.builder(
              itemCount: productService.productListmodel.length,
              padding: const EdgeInsets.all(10.0),
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: itemWidth / itemHeight),
              itemBuilder: (context, index) {
                var items = productService.productListmodel[index];
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
                                image: NetworkImage(items.img))),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          items.title.toString(),
                          maxLines: 1,

                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.currency_rupee_rounded,
                              size: 15,
                              color: Colors.grey,
                            ),
                            const Text(
                              "000",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Icon(
                              Icons.currency_rupee_rounded,
                              size: 15,
                              color: Colors.red,
                            ),
                            Text(
                              items.price.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Text(snapshot.error.toString());
        }
      },
    );
  }
}
