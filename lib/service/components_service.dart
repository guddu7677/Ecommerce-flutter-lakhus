import 'dart:convert';

import 'package:ecommerce_app/model/privacy_policy_model.dart';
import 'package:ecommerce_app/model/term_and_condition_model.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/about_us_model.dart';
import '../model/city_model.dart';
import '../model/color_model.dart';
import '../model/size_data_model.dart';
import '../model/state_model.dart';

class ComponentsService {
  // ------------------------------------------------------
  ColorModel? colorModel;

  Future<ColorModel?> fetchColorsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("token") ?? "";
    try {
      final response = await http
          .get(Uri.parse(Config.baseApi + Config.colorsApi), headers: {
        'Content-Type': 'application/json',
        "Authorization": "Token $accessToken"
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);

        print(response.body);

        colorModel = ColorModel.fromJson(data);
        return colorModel;
      } else {
        throw Exception("Failed to load data ");
      }
    } catch (error) {
      print(error.toString());
      print("Failed to load data ");
    }
    return null;
  }

  // ------------------------------------------------------
  List<SizeDataModel> sizeDataList = [];
  Future<List<SizeDataModel>> fetchSizeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("token") ?? "";

    try {
      final response = await http
          .get(Uri.parse(Config.baseApi + Config.sizeApi), headers: {
        'Content-Type': 'application/json',
        "Authorization": "Token $accessToken"
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);

        sizeDataList = (data as List)
            .map((item) => SizeDataModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return sizeDataList;
      } else {
        throw Exception("Failed to load data ");
      }
    } catch (error) {
      print(error.toString());
      print("Failed to load data ");
    }

    return [];
  }



  // ------------------------------------------------------
  List<CityModel> cutyDataList = [];
  Future<List<CityModel>> fetchCityData() async {
    try {
      final response = await http.get(
          Uri.parse(Config.baseApi + Config.stateApi),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);

        cutyDataList = (data as List)
            .map((item) => CityModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return cutyDataList;
      } else {
        throw Exception("Failed to load data ");
      }
    } catch (error) {
      print(error.toString());
      print("Failed to load data ");
    }

    return [];
  }

  // *---------------------------------------
  TermAndConditionModel? termAndConditionModel;

  Future<TermAndConditionModel?> fetchTermAndConditionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("token") ?? "";
    try {
      final response = await http.get(
          Uri.parse(Config.baseApi + Config.TermAndConditionApi),
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Token $accessToken"
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        print(response.body);

        termAndConditionModel = TermAndConditionModel.fromJson(data);
        return termAndConditionModel;
      } else {
        throw Exception("Failed to load data ");
      }
    } catch (error) {
      print(error.toString());
      print("Failed to load data ");
    }
    return null;
  }

  // *---------------------------------------
  AboutUsModel? aboutUsModel;

  Future<AboutUsModel?> fetchAboutUsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("token") ?? "";
    try {
      final response = await http
          .get(Uri.parse(Config.baseApi + Config.aboutUsApi), headers: {
        'Content-Type': 'application/json',
        "Authorization": "Token $accessToken"
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        print(response.body);

        aboutUsModel = AboutUsModel.fromJson(data);
        return aboutUsModel;
      } else {
        throw Exception("Failed to load data ");
      }
    } catch (error) {
      print(error.toString());
      print("Failed to load data ");
    }
    return null;
  }

  // *---------------------------------------
  PrivacyPolicyModel? privacyPolicyModel;

  Future<PrivacyPolicyModel?> fetchPrivacyPolicyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("token") ?? "";
    try {
      final response = await http
          .get(Uri.parse(Config.baseApi + Config.privacyPolicyApi), headers: {
        'Content-Type': 'application/json',
        "Authorization": "Token $accessToken"
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        print(response.body);

        privacyPolicyModel = PrivacyPolicyModel.fromJson(data);
        return privacyPolicyModel;
      } else {
        throw Exception("Failed to load data ");
      }
    } catch (error) {
      print(error.toString());
      print("Failed to load data ");
    }
    return null;
  }
}
