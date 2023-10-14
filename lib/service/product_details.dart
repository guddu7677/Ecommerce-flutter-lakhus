import 'dart:convert';

import 'package:ecommerce_app/model/product_details_model.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/product_filter_model.dart';

class ProductDetailsService {
  ProductDetailsModel? productDetailsModel;

  Future<ProductDetailsModel?> fetchProductDetailsData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    // accessToken = prefs.getInt("id");
    try {
      final response = await http.get(
          Uri.parse("${Config.baseApi + Config.userProductDetailsApi + id}/"),
          headers: {
            'Content-Type': 'application/json',
            "Authorization":"Token $token"
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        print(response.body);

        productDetailsModel = ProductDetailsModel.fromJson(data);
        return productDetailsModel;
      } else {
        throw Exception("Failed to load data ");
      }
    } catch (error) {
      print(error.toString());
      print("Failed to load data ");
    }
    return null;
  }

  // product fillter

  // Product? product;

  // Future<Product?> fetchProductFilterData() async {
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // accessToken = prefs.getInt("id");
  //   try {
  //     final response = await http.get(
  //         // ignore: unnecessary_string_interpolations
  //         Uri.parse(
  //           "${Config.baseApi + Config.productFilterApi}",
  //         ),
  //         headers: {
  //           'Content-Type': 'application/json',
  //         });

  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);

  //       print(response.body);

  //       product = Product.fromJson(data);
  //       return product;
  //     } else {
  //       throw Exception("Failed to load data ");
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //     print("Failed to load data ");
  //   }
  //   return null;
  // }
}
