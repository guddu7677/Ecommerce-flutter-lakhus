import 'dart:convert';

import 'package:ecommerce_app/model/filter_data_model.dart';
import 'package:ecommerce_app/model/product_filter_list_model.dart';
import 'package:ecommerce_app/model/product_list_model.dart';
import 'package:ecommerce_app/model/slider_product_model.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/sub_category_product_model.dart';

class ProductService {
  List<ProductListModel> productListmodel = [];

  Future<List<ProductListModel>> fetchProductListData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    final response = await http
        .get(Uri.parse(Config.baseApi + Config.userProductListApi), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    });
    print(token);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData is List<dynamic>) {
        productListmodel = responseData
            .map((data) => ProductListModel.fromJson(data))
            .toList();
        return productListmodel;
      } else {
        throw Exception("Invalid response format");
      }
    } else {
      print(response.body);
      throw Exception("Failed to load data");
    }
  }
  // --------------------------------------------------------------------

  List<SubCategoryProductModel> subProductListmodel = [];

  Future<List<SubCategoryProductModel>> fetchSubProductListData(
      String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    final response = await http.get(
        Uri.parse("${Config.baseApi + Config.subCategoryProductApi}$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        });
    print(token);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData is List<dynamic>) {
        subProductListmodel = responseData
            .map((data) => SubCategoryProductModel.fromJson(data))
            .toList();
        return subProductListmodel;
      } else {
        throw Exception("Invalid response format");
      }
    } else {
      print(response.body);
      throw Exception("Failed to load data");
    }
  }

  // --------------------------------------------------------
  List<ProductFilterListModel> trendingProductListmodel = [];

  Future<List<ProductFilterListModel>> fetchTrendingProductListData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    final response = await http.get(
        Uri.parse("${Config.baseApi}/product/filter/list/api/?trending=true"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        });

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData is List<dynamic>) {
        trendingProductListmodel = responseData
            .map((data) => ProductFilterListModel.fromJson(data))
            .toList();
        return trendingProductListmodel;
      } else {
        throw Exception("Invalid response format");
      }
    } else {
      print(response.body);
      throw Exception("Failed to load data");
    }
  }

  // --------------------------------------------------------
  List<SliderProductModel> sliderProductListmodel = [];

  Future<List<SliderProductModel>> fetchSliderProductListData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    final response = await http.get(
        Uri.parse(Config.baseApi + Config.sliderProductApi + id),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        });

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData is List<dynamic>) {
        sliderProductListmodel = responseData
            .map((data) => SliderProductModel.fromJson(data))
            .toList();
        return sliderProductListmodel;
      } else {
        throw Exception("Invalid response format");
      }
    } else {
      print(response.body);
      throw Exception("Failed to load data");
    }
  }

  List<FilterDataModel> filterDataList = [];

  Future<List<FilterDataModel>> fetchFilterProductListData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    final response = await http.get(
        Uri.parse(Config.baseApi + "/product/filter/list/api/?category=$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        });

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print("filterrrrrrr");

      if (responseData is List<dynamic>) {
        filterDataList =
            responseData.map((data) => FilterDataModel.fromJson(data)).toList();
        return filterDataList;
      } else {
        throw Exception("Invalid response format");
      }
    } else {
      print(response.body);
      throw Exception("Failed to load data");
    }
  }
}
