import 'dart:convert';

import 'package:ecommerce_app/model/category_model.dart';
import 'package:ecommerce_app/model/sub_category_model.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  List<CategoryModel> categoryListmodel = [];

  Future<List<CategoryModel>> fetchCategoryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    final response = await http.get(
      Uri.parse(Config.baseApi + Config.categoryApi),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token'
      },
    );
    print(token);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      print(response.body);

      // Ensure the response is a List<dynamic> type
      if (responseData is List<dynamic>) {
        // Use a loop to parse each object in the list
        categoryListmodel =
            responseData.map((data) => CategoryModel.fromJson(data)).toList();
        return categoryListmodel;
      } else {
        throw Exception("Invalid response format");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  List<SubCategoryModel> subCategoryListmodel = [];

  Future<List<SubCategoryModel>> fetchSubCategoryData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    final response = await http.get(
      Uri.parse("${Config.baseApi + Config.subCategoryApi}$id/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token'
      },
    );
    print(token);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      print(response.body);

      // Ensure the response is a List<dynamic> type
      if (responseData is List<dynamic>) {
        // Use a loop to parse each object in the list
        subCategoryListmodel = responseData
            .map((data) => SubCategoryModel.fromJson(data))
            .toList();
        return subCategoryListmodel;
      } else {
        throw Exception("Invalid response format");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }
}
