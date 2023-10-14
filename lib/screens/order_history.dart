import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text("Orders"),
        centerTitle: true,
        backgroundColor: whiteColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.search,
                size: 28,
              )),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            ListTile(
              leading: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                        fit: BoxFit.cover, image: AssetImage("assets/e1.png"))),
              ),
              title: Text(
                "Bershka Mom Jeans",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Row(
                children: [
                  Text(
                    "Curret Order- ",
                    style: TextStyle(color: purpleColor),
                  ),
                  Text(
                    "Apr 14",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            ...List.generate(
                4,
                (index) => ListTile(
                      leading: Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/e2.png"))),
                      ),
                      title: Text(
                        "Bershka Mom Jeans",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            "2 Product- ",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          Text(
                            "Apr 14",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
