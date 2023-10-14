import 'package:ecommerce_app/service/components_service.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _TermAndConditionState();
}

class _TermAndConditionState extends State<PrivacyPolicyScreen> {
  ComponentsService componentsService = ComponentsService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    componentsService.fetchPrivacyPolicyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: orangeColor),
          title: Text("Privacy Policy", style: TextStyle(color: orangeColor)),
        ),
        body: FutureBuilder(
          future: componentsService.fetchPrivacyPolicyData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: HtmlWidget(
                        componentsService.privacyPolicyModel!.txt.toString(),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Text(snapshot.error.toString());
            }
          },
        ));
  }
}
