import 'package:ecommerce_app/model/cart_product_provider.dart';
import 'package:ecommerce_app/screens/cart/cart_item.dart';
import 'package:ecommerce_app/screens/cart/pdf_genrate.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:ecommerce_app/widget/custome_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:provider/provider.dart';

import '../service/cart_provider.dart';

class CartScreenPage extends StatefulWidget {
  const CartScreenPage({super.key});

  @override
  State<CartScreenPage> createState() => _CartScreenPageState();
}

class _CartScreenPageState extends State<CartScreenPage> {
  final FlutterCart cart = FlutterCart();
  var totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Cart>(
      context,
    );

    // final cartCount = cartProvider.cart.getCartItemCount();
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Icon(
            CupertinoIcons.cart,
            size: 32,
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: provider.fetchGetCartData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  provider.getCartmodel.isEmpty
                      ? const Center(
                          child: Text("No Item Found"),
                        )
                      : Expanded(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0.0),
                            itemCount: provider.getCartmodel.length,
                            itemBuilder: (_, index) {
                              // Cart order = listCart[index];
                              var item = provider.getCartmodel[index];

                              print(provider.calculateTotalPrice().toString());
                              // String valueColor = item.productColor!
                              //     .replaceAll('Color(', '')
                              //     .replaceAll(')', '');
                              //     int color = int.parse(valueColor.toString());
                              //     print(color);

                              return Column(
                                children: [
                                  CartItem(
                                    id: item.id.toString(),
                                    color: item.productColor.toString(),
                                    productImage: item.img.toString(),
                                    productName: item.productTitle.toString(),
                                    productQuantity: item.quantity.toString(),
                                    productSize: item.productSize.toString(),
                                    productprice: item.productPrice.toString(),
                                    index: index,
                                  ),
                                  const Divider()
                                ],
                              );
                            },
                          ),
                        ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: orangeColor,
                ),
              );
            }
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Total: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "₹${provider.calculateTotalPrice().toString()}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PdfPreviewPage(
                        pdfData: provider.getCartmodel,
                        total: provider.calculateTotalPrice(),
                      );
                    }));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    decoration: BoxDecoration(
                      color: orangeColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "Place Order",
                        style: TextStyle(color: whiteColor, fontSize: 16),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
