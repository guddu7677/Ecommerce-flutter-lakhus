import 'package:ecommerce_app/service/components_service.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TermAndCondition extends StatefulWidget {
  const TermAndCondition({super.key});

  @override
  State<TermAndCondition> createState() => _TermAndConditionState();
}

class _TermAndConditionState extends State<TermAndCondition> {
  ComponentsService componentsService = ComponentsService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    componentsService.fetchTermAndConditionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: orangeColor),
          title:
              Text("Terms & Condition's", style: TextStyle(color: orangeColor)),
        ),
        body: FutureBuilder(
          future: componentsService.fetchTermAndConditionData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return  SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: HtmlWidget(
                        componentsService.termAndConditionModel!.txt.toString(),
                        textStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Text(snapshot.error.toString());
            }
          },
        ));
  }
}
