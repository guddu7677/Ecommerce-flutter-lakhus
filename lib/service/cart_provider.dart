import 'package:ecommerce_app/service/config.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/get_cart_model.dart';

class Cart with ChangeNotifier {
  bool isLaoding = false;

  Future<void> addToCart(String img, String title, String size, String color,
      double price, String productId, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? -1;
    String token = prefs.getString("token") ?? "";
    isLaoding = true;
    notifyListeners();
    final url = Uri.parse(Config.baseApi + Config.createCartApi);
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token $token"
      },
      body: json.encode({
        'img': img,
        'product_title': title,
        'product_size': size,
        'product_color': color,
        'product_price': price,
        'product': productId,
        "quantity": 2,
        'user': id
      }),
    );
    log(response.body);
    log("sss${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      log("sss${response.statusCode}");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Added To Cart")));
      isLaoding = false;
      notifyListeners();
    } else {
      log("sss${response.statusCode}");
    }
  }

  // /

  Future<void> cartIncreament(String quantity, String userId, String prodcutcId,
      String sizeId, String colorId, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? -1;
    String token = prefs.getString("token") ?? "";

    notifyListeners();
    final url = Uri.parse(
        Config.baseApi + Config.cartIncreanentApi + "/$prodcutcId/increament");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Token $token"
        },
        body: json.encode({
          "quantity": quenTity,
          "user": userId,
          "product": prodcutcId,
          "size_price": sizeId,
          "color_images": colorId
        }));
    log(response.body);
    log("sss${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      log("sss${response.statusCode}");

      notifyListeners();
    } else {
      log("sss${response.statusCode}");
    }
  }
  // -------------------------

  List<GetCartModel> getCartmodel = [];

  Future<List<GetCartModel>> fetchGetCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    final response =
        await http.get(Uri.parse(Config.baseApi + Config.getCartApi), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    });
    print(token);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData is List<dynamic>) {
        getCartmodel =
            responseData.map((data) => GetCartModel.fromJson(data)).toList();

        print(response.body);
        notifyListeners();
        return getCartmodel;
      } else {
        throw Exception("Invalid response format");
      }
    } else {
      print(response.body);
      throw Exception("Failed to load data");
    }
  }

  double quenTity = 1;
  double calculateTotalPrice() {
    double totalPrice = 0.0;
    double totalPrices = 0.0;
    for (var item in getCartmodel) {
      double? price = double.tryParse(item.productPrice.toString());
      if (price != null) {
        totalPrice += price;
        totalPrices = quenTity * totalPrice;
        print(totalPrice.toString());
      } else {
        print(
            'Could not parse price for item ${item.id} (price: "${item.productPrice}")');
      }
    }
    return totalPrice;
  }

  // ---------------
  int get totalItemCount {
    return getCartmodel.length;
  }

  // -------------------------------------

  Future<void> deletData(String id, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    final response = await http.delete(
        Uri.parse("${Config.baseApi + Config.deletCartApi}$id/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        });

    if (response.statusCode == 200 || response.statusCode == 204) {
      print(totalItemCount.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Item Removed",
        style: TextStyle(color: orangeColor),
      )));
      notifyListeners();
    } else {
      print(response.body);
      // throw Exception('Failed to load data');
    }
  }
  // ---------------

  Future<void> updateData(String id, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    final response = await http.delete(
        Uri.parse("${Config.baseApi + Config.quantityCartApi}$id/"),
        body: json.encode({}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        });

    if (response.statusCode == 200 || response.statusCode == 204) {
      notifyListeners();
    } else {
      print(response.body);
      // throw Exception('Failed to load data');
    }
  }
}
