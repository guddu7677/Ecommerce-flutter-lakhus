import 'package:ecommerce_app/service/components_service.dart';
import 'package:ecommerce_app/service/product_list_service.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool viewNewProduct = false;
  bool viewProductOnSale = false;
  List<String> selectedColors = [];
  List<String> selectedSizes = [];
  List<String> selectedTags = [];
  String? selectedBrand;
  ComponentsService componentsService = ComponentsService();

  List<String> colors = ["Red", "Blue", "Green", "Yellow"];
  List<String> sizes = ["S", "M", "L", "XL"];
  List<String> tags = ["Tag1", "Tag2", "Tag3", "Tag4"];
  List<String> brands = ["Brand1", "Brand2", "Brand3", "Brand4"];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, -1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          const Center(
            child: Text(
              "Filters",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          ListTile(
            title: const Text("View New Product"),
            trailing: Switch(
              value: viewNewProduct,
              onChanged: (value) {
                setState(() {
                  viewNewProduct = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text("View Product on Sale"),
            trailing: Switch(
              value: viewProductOnSale,
              onChanged: (value) {
                setState(() {
                  viewProductOnSale = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text("Colors"),
            subtitle: const Text(
              "View all",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Select Colors"),
                  content: SingleChildScrollView(
                    child: Column(
                      children: colors.map((color) {
                        return CheckboxStateful(
                          title: color,
                          isChecked: selectedColors.contains(color),
                          onChanged: (value) {
                            setState(() {
                              if (value) {
                                selectedColors.add(color);
                              } else {
                                selectedColors.remove(color);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text("Done"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                // Open colors dialog
              },
            ),
          ),
          ListTile(
            title: const Text("Sizes"),
            subtitle: const Text(
              "View all",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Select Sizes"),
                  content: SingleChildScrollView(
                    child: Column(
                      children: sizes.map((size) {
                        return CheckboxStateful(
                          title: size,
                          isChecked: selectedSizes.contains(size),
                          onChanged: (value) {
                            setState(() {
                              if (value) {
                                selectedSizes.add(size);
                              } else {
                                selectedSizes.remove(size);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text("Done"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                // Open sizes dialog
              },
            ),
          ),
          ListTile(
            title: const Text("Tags"),
            subtitle: const Text(
              "View all",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Select Tags"),
                  content: SingleChildScrollView(
                    child: Column(
                      children: tags.map((tag) {
                        return CheckboxStateful(
                          title: tag,
                          isChecked: selectedTags.contains(tag),
                          onChanged: (value) {
                            setState(() {
                              if (value) {
                                selectedTags.add(tag);
                              } else {
                                selectedTags.remove(tag);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text("Done"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                // Open tags dialog
              },
            ),
          ),
          ListTile(
            title: const Text("Brand"),
            subtitle: const Text(
              "View all",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: whiteColor,
                  title: const Text("Select Brand"),
                  content: SingleChildScrollView(
                    child: Column(
                      children: brands.map((brand) {
                        return RadioListTile<String>(
                          title: Text(brand),
                          value: brand,
                          groupValue: selectedBrand,
                          onChanged: (value) {
                            setState(() {
                              selectedBrand = value;
                            });
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  hoverColor: Colors.orange,
                  onTap: () {
                    setState(() {
                      viewNewProduct = false;
                      viewProductOnSale = false;
                      selectedColors.clear();
                      selectedSizes.clear();
                      selectedTags.clear();
                      selectedBrand = null;
                    });
                  },
                  child: Container(
                    width: 111,
                    height: 52,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffE7E7E8),
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            color: Color(0xffB7B7B8),
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  hoverColor: Colors.orange,
                  onTap: () {
                    List<String> selectedOptions = [];
                    if (viewNewProduct) {
                      selectedOptions.add("View New Product");
                    }
                    if (viewProductOnSale) {
                      selectedOptions.add("View Product on Sale");
                    }
                    selectedOptions.addAll(selectedColors);
                    selectedOptions.addAll(selectedSizes);
                    selectedOptions.addAll(selectedTags);
                    if (selectedBrand != null) {
                      selectedOptions.add(selectedBrand!);
                    }

                    // Print the selected options
                    print("Selected Options: $selectedOptions");

                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.58,
                    height: 52,
                    decoration: BoxDecoration(
                        color: orangeColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        "View all products",
                        style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CheckboxStateful extends StatefulWidget {
  final String title;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  CheckboxStateful(
      {required this.title, required this.isChecked, required this.onChanged});

  @override
  _CheckboxStatefulState createState() => _CheckboxStatefulState();
}

class _CheckboxStatefulState extends State<CheckboxStateful> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: _isChecked,
      onChanged: (value) {
        setState(() {
          _isChecked = value!;
        });
        widget.onChanged(value!);
      },
    );
  }
}
