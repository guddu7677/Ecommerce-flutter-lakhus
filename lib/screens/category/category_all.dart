import 'package:ecommerce_app/screens/category/category_ontap_view.dart';
import 'package:ecommerce_app/screens/category/category_tap.dart';
import 'package:ecommerce_app/service/category_service.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/material.dart';

class CategoryAllView extends StatefulWidget {
  String id;
  CategoryAllView({super.key, required this.id});

  @override
  State<CategoryAllView> createState() => _GridViewProductScreenState();
}

class _GridViewProductScreenState extends State<CategoryAllView> {
  CategoryService categoryService = CategoryService();
  List images = [
    "assets/1.png",
    "assets/2.png",
    "assets/3.png",
    "assets/4.png",
    "assets/5.png",
    "assets/6.png",
  ];
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
    categoryService.fetchSubCategoryData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 30) / 2.3;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: categoryService.fetchSubCategoryData(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: categoryService.subCategoryListmodel.length,
            padding: const EdgeInsets.all(10.0),
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                childAspectRatio: itemWidth / itemHeight),
            itemBuilder: (context, index) {
              var item = categoryService.subCategoryListmodel[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryTapView(title: item.id.toString(),titless: item.name.toString(), ),
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
                              image: NetworkImage(Config.baseApi+item.img.toString()))),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        item.name.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(backgroundColor: orangeColor),
          );
        } else {
          return Text(snapshot.error.toString());
        }
      },
    );
  }
}
