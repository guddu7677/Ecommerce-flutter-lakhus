import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  final FlutterCart cart = FlutterCart();

  CartProvider() {
    // loadCart();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    var cartData = prefs.getString('cart');
    if (cartData != null) {
      // loadCart();
    }
    notifyListeners();
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = cart.cartItem;
    await prefs.setString('cart', cartData.toString());
  }

//  Future<void> loadCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartData = prefs.getString('cart');
//     if (cartData != null) {
//       final cartItemsList = jsonDecode(cartData) as List<dynamic>;
//       cartItemsList.forEach((cartItem) {
//         cart.addToCart(
//           CartItems(
//             productId: cartItem['productId'],
//             unitPrice: cartItem['unitPrice'],
//             quantity: cartItem['quantity'],
//             productName: cartItem['productName'],
//             image: cartItem['image'],
//             color: cartItem['color'],
//             size: cartItem['size'],
//           ),
//         );
//       });
//     }
//     notifyListeners();
//   }

  void addToCart({
    required String productId,
    required double unitPrice,
    int quantity = 1,
    required String productName,
    required String image,
    required String size,
    required String color,
  })
  
   {
    final Map<String, dynamic> cartItemsss = {
      'image': image,
      'color': color,
      'size': size,
    };
    cart.addToCart(
      productId: productId,
      unitPrice: unitPrice,
      quantity: quantity,
      productName: productName,
      productDetailsObject: cartItemsss,

      
    );
    saveCart();
    notifyListeners();
  }

  void removeFromCart(int index) {
    cart.deleteItemFromCart(index);
    saveCart();
    notifyListeners();
  }

  void clearCart() {
    cart.deleteAllCart();
    saveCart();
    notifyListeners();
  }
}
