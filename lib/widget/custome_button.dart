import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  String title;
  CustomeButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.07,
      decoration: BoxDecoration(
          color: orangeColor, borderRadius: BorderRadius.circular(12)),
      child: Center(
          child: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.white),
      )),
    );
  }
}
