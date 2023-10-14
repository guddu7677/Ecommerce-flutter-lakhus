import 'dart:convert';

import 'package:ecommerce_app/model/profile_details_model.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  ProfileDetailsModel? profiletDetailsModel;

  Future<ProfileDetailsModel?> fetchProfileDetailsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    int id = prefs.getInt('id') ?? -0;
    // accessToken = prefs.getInt("id");
    try {
      final response = await http.get(
          Uri.parse(
              "${Config.baseApi + Config.ProfileDetailsApi + id.toString()}/"),
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Token $token"
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        print(response.body);

        profiletDetailsModel = ProfileDetailsModel.fromJson(data);
        return profiletDetailsModel;
      } else {
        // print(response.body);
        throw Exception("Failed to load data ");
      }
    } catch (error) {
      print(error.toString());
      print("Failed to load data ");
    }
    return null;
  }
}
