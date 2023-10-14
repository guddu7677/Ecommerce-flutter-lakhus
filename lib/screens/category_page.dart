import 'package:ecommerce_app/screens/home_tab_screens/grid_view/category_grid_view.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "All Category",
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
            CategoryGridViewProductScreen()
          ],
        ),
      ),
    );
  }
}
