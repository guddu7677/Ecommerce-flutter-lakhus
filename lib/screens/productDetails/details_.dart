import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ecommerce_app/model/cart_product_provider.dart';
import 'package:ecommerce_app/screens/productDetails/product_details_page.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:ecommerce_app/widget/custome_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/cart_provider.dart';

class Details_ extends StatefulWidget {
  String description;
  String productTitle;
  String productId;
  String quantity;
  double price;
  String images;
  String size;
  String color;

  Details_({
    super.key,
    required this.description,
    required this.images,
    required this.price,
    required this.productId,
    required this.productTitle,
    required this.quantity,
    required this.color,
    required this.size,
  });

  @override
  State<Details_> createState() => _Details_State();
}

class _Details_State extends State<Details_> {
  bool isVisble = false;
  bool isLoging = false;
  List images = [
    "assets/e1.png",
    "assets/e2.png",
    "assets/cwest.png",
  ];
  late CartProvider cartProvider;
  late int cartCount;
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // cartProvider = Provider.of<CartProvider>(context);
  //   // cartCount = cartProvider.cart.getCartItemCount();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<Cart>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 18.0,
          ),
          const Text(
            "Details",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text(
            "Description",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8.0,
          ),
          HtmlWidget(
            widget.description,
            textStyle: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text(
            "How it Fits",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            "- Loose through your hip and thigh Supr high rise\n- Model is 5'9 and is wearing a size 27 waist",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 8.0,
          ),
          SizedBox(
            height: 18.0,
          ),
          InkWell(
              onTap: () async {
                // addToCart(widget.productTitle, widget.size, widget.color, widget.price.toString())
                if (widget.size == "") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please Select Size!",
                        style: TextStyle(color: orangeColor)),
                    backgroundColor: whiteColor,
                  ));
                } else if (widget.color == "") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please Select Color!",
                        style: TextStyle(color: orangeColor)),
                    backgroundColor: whiteColor,
                  ));
                } else {
                  provider.addToCart(widget.images, widget.productTitle,
                      widget.size, widget.color, widget.price,widget.productId.toString() ,context);
                }
                // cartProvider.addToCart(
                //     productId: widget.productId,
                //     unitPrice: widget.price,
                //     productName: widget.productTitle,
                //     color: widget.color,
                //     image: widget.images,
                //     size: widget.size,
                //     quantity: 1);

                // setState(() {
                //   cartCount = cartProvider.cart.getCartItemCount();
                //   // print(cartProvider.cart.cartItem[2].productName.toString());
                // });
                // await cartProvider.saveCart();
              },
              child: provider.isLaoding
                  ? Center(
                      child: CircularProgressIndicator(
                      color: orangeColor,
                    ))
                  : CustomeButton(title: "Add To Cart")),
          SizedBox(
            height: 10.0,
          ),
          ListTile(
            title: const Text(
              "Tags",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () {
              if (isVisble == false) {
                setState(() {
                  isVisble = true;
                });
              } else {
                if (isVisble == true) {
                  setState(() {
                    isVisble = false;
                  });
                }
              }
            },
            trailing: IconButton(
                onPressed: () {
                  if (isVisble == false) {
                    setState(() {
                      isVisble = true;
                    });
                  } else {
                    if (isVisble == true) {
                      setState(() {
                        isVisble = false;
                      });
                    }
                  }
                },
                icon: isVisble
                    ? const Icon(Icons.keyboard_arrow_up_outlined)
                    : const Icon(Icons.keyboard_arrow_down_outlined)),
          ),
          isVisble
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tags("Vintage"),
                    tags("Vintage"),
                    tags("Vintage"),
                    tags("Vintage"),
                  ],
                )
              : const SizedBox(
                  height: 20.0,
                ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            "Complete your outfit",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: size.height * 0.4,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              physics: const ScrollPhysics(),
              itemCount: images.length, // Replace with your actual item count
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            id: "",
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
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(images[index]))),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Product/Collection",
                          style: TextStyle(fontSize: 16),
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
                                  decoration: TextDecoration.lineThrough,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------

  Future<void> addToCart(
    String title,
    String size,
    String color,
    String price,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    int id = prefs.getInt('id') ?? -1;
    setState(() {
      isLoging = true;
    });
    final response = await http.post(
      Uri.parse(Config.baseApi + Config.addToCartApi),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Token $token"
      },
      body: jsonEncode({
        "user": id,
        "product": 1,
        "product_title": "jeans",
        "product_size": "xl",
        "product_color": "#00000",
        "product_price": 250
      }),
    );
    print(response.body);
    var dataa = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added to Cart')),
      );

      setState(() {
        isLoging = false;
      });

      print(response.body);
    } else {
      // ignore: use_build_context_synchronously
      AnimatedSnackBar.rectangle(
        'Failed to Add Cart',
        "Failled",
        type: AnimatedSnackBarType.warning,
        brightness: Brightness.light,
      ).show(
        context,
      );
      setState(() {
        isLoging = false;
      });

      print(response.body);
    }
  }

  // --------------------------------------------

  Widget tags(String title) {
    return Container(
      width: 70,
      height: 35,
      decoration: BoxDecoration(
          color: const Color(0xffEFEDFC),
          borderRadius: BorderRadius.circular(4)),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
