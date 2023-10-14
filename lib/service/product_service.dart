import 'dart:convert';
import 'package:ecommerce_app/service/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/search_model.dart';

class ProductsService {
  List<SearchModel> searchList = [];
  Future<List<SearchModel>> search(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    final response = await http
        .get(Uri.parse(Config.baseApi + Config.searchApi + query), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      searchList =
          (data as List).map((item) => SearchModel.fromJson(item)).toList();
      return searchList;
    } else {
      print(response.body);
      throw Exception('Failed to load search results.');
    }
  }
}
