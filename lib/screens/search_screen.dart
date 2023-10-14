import 'package:ecommerce_app/screens/search_result.dart';
import 'package:flutter/material.dart';

import '../service/product_service.dart';
import '../widget/color.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> searchResults = [];
  ProductsService productsService = ProductsService();

  @override
  void initState() {
    super.initState();

    searchController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    productsService.search(searchController.text).then((value) {
      setState(() {
        searchResults = value.map((v) => v.title as String).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: TextStyle(color: orangeColor)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height * 0.06,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: TextFormField(
                controller: searchController,
                onTap: () {
                  setState(() {});
                },
                onFieldSubmitted: (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchResultsPage(query: searchController.text),
                      ));
                },
                decoration: InputDecoration(
                    hintText: "Search on Lekhus",
                    suffixIcon: Icon(
                      Icons.search,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            searchResults.isEmpty
                ? SizedBox(
                    height: 0,
                  )
                : Expanded(
                    child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  searchController.text = searchResults[index];
                                });
                              },
                              child: Text(searchResults[index],
                                  style: TextStyle(fontSize: 16)),
                            ),
                            Divider(
                              color: Colors.grey,
                            )
                          ],
                        ),
                      );
                    },
                  )),
          ],
        ),
      ),
    );
  }
}
