import 'package:ecommerce_app/screens/category/category_ontap_view.dart';
import 'package:ecommerce_app/service/category_service.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/material.dart';

class CategoryGridViewProductScreen extends StatefulWidget {
  const CategoryGridViewProductScreen({super.key});

  @override
  State<CategoryGridViewProductScreen> createState() =>
      _GridViewProductScreenState();
}

class _GridViewProductScreenState extends State<CategoryGridViewProductScreen> {

  CategoryService categoryService = CategoryService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryService.fetchCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 30) / 2.6;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: categoryService.fetchCategoryData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: categoryService.categoryListmodel.length,
            padding: const EdgeInsets.all(10.0),
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                childAspectRatio: itemWidth / itemHeight),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryOnTapView(title: categoryService.categoryListmodel[index].id.toString(),titless: categoryService.categoryListmodel[index].name.toString(), ),
                      ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width *
                          0.45, // Adjust the width as per your requirements
                      height: size.height * 0.25,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(categoryService
                                  .categoryListmodel[index].img
                                  .toString()))),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        categoryService.categoryListmodel[index].name
                            .toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          // ignore: prefer_const_constructors
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(
                  color: orangeColor,
                ),
              ),
            ],
          );
        } else {
          return Text(snapshot.error.toString());
        }
      },
    );
  }
}
