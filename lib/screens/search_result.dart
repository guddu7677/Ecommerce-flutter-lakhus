import 'package:ecommerce_app/screens/productDetails/product_details_page.dart';
import 'package:flutter/material.dart';

import '../service/config.dart';
import '../service/product_service.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  SearchResultsPage({Key? key, required this.query}) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final ProductsService productService = ProductsService();
  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();

    productService.search(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 30) / 2.1;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for "${widget.query}"'),
      ),
      body: FutureBuilder(
        future: productService.search(widget.query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              // controller: _scrollController,
              itemCount: productService.searchList.length,
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
                var items = productService.searchList[index];
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
                              image: NetworkImage(productService
                                  .searchList[index].img
                                  .toString()),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            items.title.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
    );
  }
}
