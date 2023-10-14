import 'package:flutter/material.dart';

class ColorModel {
  List<ColorData> colors;

  ColorModel({required this.colors});

  factory ColorModel.fromJson(List<dynamic> json) {
    List<ColorData> colorList =
        json.map((color) => ColorData.fromJson(color)).toList();
    return ColorModel(colors: colorList);
  }
}

class ColorData {
  final int id;
  final String color;

  ColorData({required this.id, required this.color});

  factory ColorData.fromJson(Map<String, dynamic> json) {
    return ColorData(
      id: json['id'] ,
      color: json['color'], // Adjust this line to correctly convert your color data to a Flutter Color object
    );
  }
}
