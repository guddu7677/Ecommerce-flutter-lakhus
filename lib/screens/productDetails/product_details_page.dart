import 'package:ecommerce_app/model/cart_product_provider.dart';
import 'package:ecommerce_app/screens/productDetails/details_.dart';
import 'package:ecommerce_app/screens/productDetails/select_colors.dart';
import 'package:ecommerce_app/service/components_service.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:ecommerce_app/service/product_details.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:ecommerce_app/widget/custome_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/color_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  String id;
  ProductDetailsScreen({super.key, required this.id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedSizeIndex = -1;
  ProductDetailsService productDetailsService = ProductDetailsService();
  ComponentsService componentsService = ComponentsService();
  List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  List<String> ages = ['26', '28', '30', '32', '34'];
  int selectedIndex = 0;
  String selectedSize = "";
  String selectedColor = "";
  int selectedColorIndex = 0;

  // List<dynamic> availableColors = [];
  List images = [
    "assets/e1.png",
    "assets/e2.png",
    "assets/cwest.png",
  ];

  // ---------------------------------------------------------
  void _openColorBottomSheet() {
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
                itemCount: availableColorsInColorFormat.length,
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
                                color: availableColorsInColorFormat[index],
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
                            selectedColor =
                                availableColorsInColorFormat[selectedColorIndex]
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

  // ---------------------------------------------------------
  void _openBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                "Size",
                style: TextStyle(color: blackColor, fontSize: 18),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: availableSizes.length,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Row(
                        children: [
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(availableSizes[index]),
                        ],
                      ),
                      trailing: (selectedSizeIndex == index)
                          ? Icon(Icons.check_circle, color: purpleColor)
                          : null,
                      onTap: () {
                        setState(() {
                          selectedSizeIndex = index;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int currentIndex = 0;
  // Define these two lists at the class level
  List<ColorData> colorDataList = [];
  Map<String, dynamic> colorMap = {};

  List<ColorData> availableColors = [];
  List<Color> availableColorsInColorFormat =
      []; // New list to store the Color objects

  Future<void> filterAvailableColors() async {
    var productDetails =
        await productDetailsService.fetchProductDetailsData(widget.id);

    if (productDetails != null) {
      var productColorIds = productDetails.color;

      var colorApiResponse = await componentsService.fetchColorsData();

      if (colorApiResponse != null) {
        colorDataList = colorApiResponse.colors;

        colorMap = {
          for (var colorData in colorDataList)
            colorData.id.toString(): colorData.color
        };
        print("Color map: $colorMap");

        if (productColorIds != null) {
          for (var id in productColorIds) {
            if (colorMap.containsKey(id.toString())) {
              setState(() {
                ColorData newColorData =
                    ColorData(id: id, color: colorMap[id.toString()]!);
                availableColors.add(newColorData);
                String valueString = newColorData.color.replaceAll('#', '');
                int value = int.parse(valueString, radix: 16);
                availableColorsInColorFormat.add(Color(value + 0xFF000000));
              }); // Add to the Color list
            } else {
              print("Color not found for id: $id");
            }
          }
        } else {
          print("Product color ids are null");
        }

        print("Available colors: $availableColors");
        print(
            "Available colors in Color format: $availableColorsInColorFormat");
      } else {
        print("Color API response is null");
      }
    } else {
      print("Product details are null");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productDetailsService.fetchProductDetailsData(widget.id);

    filterAvailableColors();
    filterAvailableSizeData();
    selectedIndex = -1;
    selectedColorIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz_outlined,
                  size: 28,
                )),
            const SizedBox(
              width: 10.0,
            )
          ],
        ),
        body: FutureBuilder(
          future: productDetailsService.fetchProductDetailsData(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(Config.baseApi +
                                  productDetailsService.productDetailsModel!
                                      .images![currentIndex].img
                                      .toString()))),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: size.height * 0.1,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                physics: const ScrollPhysics(),
                                itemCount: productDetailsService
                                    .productDetailsModel!
                                    .images!
                                    .length, // Replace with your actual item count
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                    child: Container(
                                      width: size.width *
                                          0.2, // Adjust the width as per your requirements
                                      height: size.height * 0.05,
                                      margin: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: currentIndex == index
                                                  ? blackColor
                                                  : Colors.transparent,
                                              width: 2.0),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  Config.baseApi +
                                                      productDetailsService
                                                          .productDetailsModel!
                                                          .images![index]
                                                          .img
                                                          .toString()))),
                                    ),
                                  );
                                },
                              )),
                          Text(
                            productDetailsService.productDetailsModel!.title
                                .toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.currency_rupee_outlined),
                              Text(
                                productDetailsService.productDetailsModel!.price
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      title: const Text("Select Size",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      trailing: GestureDetector(
                        onTap: _openBottomSheet,
                        child: const Text(
                          "View all",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff868687)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: availableSizes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSizeIndex = index;
                                selectedSize = sizes[selectedSizeIndex];
                                print(selectedSize);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.8, vertical: 8.8),
                              child: Container(
                                height: 80,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: (selectedSizeIndex == index)
                                        ? orangeColor
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    availableSizes[index].toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: (selectedSizeIndex == index)
                                          ? blackColor
                                          : Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text("Select Color",
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          trailing: GestureDetector(
                            onTap: _openColorBottomSheet,
                            child: Text(
                              "View all",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff868687)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.09,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: availableColorsInColorFormat.length,
                            itemBuilder: (context, index) {
                              // List<Color> colors = widget.availableColors.map((colorData) {
                              //   String valueString =
                              //       colorData.colorString.replaceAll('#', ''); // remove #
                              //   int value =
                              //       int.parse(valueString, radix: 16); // convert to integer
                              //   return new Color(value + 0xFF000000); // add alpha
                              // }).toList();

                              print(availableColorsInColorFormat[index]);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColorIndex = index;
                                    selectedColor =
                                        availableColorsInColorFormat[
                                                selectedColorIndex]
                                            .toString();
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
                                          color: availableColorsInColorFormat[
                                              index],
                                          border: Border.all(
                                              color: selectedColorIndex == index
                                                  ? blackColor
                                                  : Colors.transparent,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    // SelectColor(
                    //   availableColors: availableColorsInColorFormat,
                    //   selectedColor: selectedColor,
                    // ),
                    Details_(
                      description: productDetailsService
                          .productDetailsModel!.description
                          .toString(),
                      price: productDetailsService.productDetailsModel!.price!
                          .toDouble(),
                      productId: productDetailsService.productDetailsModel!.id
                          .toString(),
                      productTitle: productDetailsService
                          .productDetailsModel!.title
                          .toString(),
                      quantity: "1",
                      color: selectedColor,
                      images: productDetailsService.productDetailsModel!.img
                          .toString(),
                      size: selectedSize,
                    )
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: orangeColor,
                ),
              );
            } else {
              return Text(snapshot.error.toString());
            }
          },
        ));
  }

  List<String> availableSizes = [];

  Future<void> filterAvailableSizeData() async {
    var productDetails =
        await productDetailsService.fetchProductDetailsData(widget.id);

    if (productDetails != null) {
      var productSizeIds =
          productDetails.size; // assuming size ids are provided

      var sizeApiResponse =
          await componentsService.fetchSizeData(); // fetch size data

      // Filter available sizes based on the product's size ids
      if (sizeApiResponse != null) {
        var sizeDataList =
            sizeApiResponse.map((item) => item.name.toString()).toList();

        if (productSizeIds != null) {
          for (var id in productSizeIds) {
            if (id < sizeDataList.length) {
              // assuming id can be used as index

              availableSizes.add(sizeDataList[id]);
              print("skkk" + availableSizes.toString());
            } else {
              print("Size not found for id: $id");
            }
          }
        } else {
          print("Product size ids are null");
        }

        print("Available sizes: $availableSizes");
      } else {
        print("Size API response is null");
      }
    } else {
      print("Product details are null");
    }
  }
}
