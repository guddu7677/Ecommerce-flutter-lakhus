import 'package:ecommerce_app/model/cart_product_provider.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/cart_provider.dart';

class CartItem extends StatefulWidget {
  // final Cart order;
  String id;
  String productName;
  String productprice;
  String color;
  String productSize;
  String productQuantity;
  String productImage;
  int index;

  CartItem(
      {Key? key,
      required this.color,
      required this.id,
      required this.productName,
      required this.productQuantity,
      required this.productSize,
      required this.productprice,
      required this.productImage,
      required this.index})
      : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int? colors;
  int? userId;
  int price = 0;
  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt("id");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(Config.baseApi + widget.productImage),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Color: ",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              children: [
                                TextSpan(
                                  text: "Black",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                )
                              ]),
                        ]),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Size: ",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              children: [
                                TextSpan(
                                  text: widget.productSize,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                )
                              ]),
                        ]),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 105,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.withOpacity(.1),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  cartProvider.cartIncreament(
                                      2.toString(),
                                      userId.toString(),
                                      widget.id,
                                      widget.productSize,
                                      widget.color,
                                      context);
                                },
                                child: const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(widget.productQuantity),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  // if (cartProvider.quenTity ==
                                  //     1) {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //       const SnackBar(
                                  //           content: Text(
                                  //               "Can't Decreament Less Then 1")));
                                  // } else {
                                  //   setState(() {
                                  //    cartProvider.quenTity --;
                                  //   });
                                  // }
                                },
                                child: const Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "₹ ${widget.productprice}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  cartProvider.deletData(widget.id, context);
                });
              },
              icon: Icon(Icons.close, color: Colors.red))
        ],
      ),
    );
  }
}
