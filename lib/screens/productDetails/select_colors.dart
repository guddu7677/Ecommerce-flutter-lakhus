import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/material.dart';

class SelectColor extends StatefulWidget {
  List<dynamic> availableColors;
  String selectedColor;
  SelectColor(
      {super.key, required this.availableColors, required this.selectedColor});

  @override
  State<SelectColor> createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  // Color? selectedColor;

  int selectedColorIndex = 0;
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
  ];
  List<String> colorsName = [
    "Red",
    "Blue",
    'Green',
    "Cyellow",
    "Purple",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   selectedColorIndex=-1;
  }

  void _openBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  'All Colors',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                  child: ListView.builder(
                itemCount: widget.availableColors.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Card(
                              elevation: 4,
                              child: Icon(
                                Icons.circle,
                                color: widget.availableColors[index],
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                          
                          ],
                        ),
                        trailing: (selectedColorIndex == index)
                            ? Icon(Icons.check_circle, color: purpleColor)
                            : null,
                        onTap: () {
                          setState(() {
                            selectedColorIndex = index;
                            widget.selectedColor = widget
                                .availableColors[selectedColorIndex]
                                .toString();
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              ))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text("Select Color",
              style: TextStyle(
                fontSize: 16,
              )),
          trailing: GestureDetector(
            onTap: _openBottomSheet,
            child: Text(
              "View all",
              style: TextStyle(fontSize: 12, color: Color(0xff868687)),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.09,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.availableColors.length,
            itemBuilder: (context, index) {
              // List<Color> colors = widget.availableColors.map((colorData) {
              //   String valueString =
              //       colorData.colorString.replaceAll('#', ''); // remove #
              //   int value =
              //       int.parse(valueString, radix: 16); // convert to integer
              //   return new Color(value + 0xFF000000); // add alpha
              // }).toList();

              print(widget.availableColors[index]);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColorIndex = index;
                    widget.selectedColor =
                        widget.availableColors[selectedColorIndex].toString();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.8, vertical: 5.8),
                  child: Card(
                    elevation: 3.0,
                    child: Container(
                      height: 80,
                      width: 55,
                      decoration: BoxDecoration(
                          color: widget.availableColors[index],
                          border: Border.all(
                              color: selectedColorIndex == index
                                  ? blackColor
                                  : Colors.transparent,
                              width: 2.0),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
