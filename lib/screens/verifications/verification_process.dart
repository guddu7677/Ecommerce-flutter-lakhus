import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce_app/screens/verifications/sign_complet.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:ecommerce_app/widget/custome_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/state_model.dart';
import '../../service/components_service.dart';

// ignore: must_be_immutable
class VerificationProcess extends StatefulWidget {
  String phone;
  VerificationProcess({super.key, required this.phone});

  @override
  State<VerificationProcess> createState() => _VerificationProcessState();
}

class _VerificationProcessState extends State<VerificationProcess> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController bussinesNameController = TextEditingController();
  ComponentsService componentsService = ComponentsService();
  bool isLoging = false;
  String? selectedState;
  String? selectedCity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneController.text = widget.phone;
    fetchStateData().then((_) {
      setState(() {});
    });
    fetchCityData().then((_) {
      setState(() {});
    });
    componentsService.fetchCityData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.12,
                          ),
                          const Text(
                            "Verification\nProcess",
                            style: TextStyle(
                                fontSize: 38, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: size.height * 0.08,
                          ),
                          TextField(
                            controller: phoneController,
                            enabled: false,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                                label: Row(
                              children: [
                                Text("Whatsapp No.",
                                    style: TextStyle(color: Colors.red)),
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            )),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            controller: bussinesNameController,
                            decoration: const InputDecoration(
                                label: Row(
                              children: [
                                Text("Business/Shop Name"),
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            )),
                          ),
                          const SizedBox(
                            height: 28.0,
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  width: size.width * 0.8,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.grey)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: const Text(
                                          "State",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: stateDataList
                                            .map<DropdownMenuItem<String>>(
                                              (Map<String, dynamic> item) =>
                                                  DropdownMenuItem<String>(
                                                value: item[
                                                    'name'], // assuming your data structure is List<Map<String, dynamic>>
                                                child: Text(item['name']),
                                              ),
                                            )
                                            .toList(),
                                        value: selectedState,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedState = value.toString();
                                          });
                                        },
                                        // Rest of your DropdownButton2 parameters
                                        // I have omitted as I am not aware of them
                                        // buttonStyleData: const ButtonStyleData(
                                        //   height: 40,
                                        //   width: 140,
                                        // ),
                                        // menuItemStyleData: const MenuItemStyleData(
                                        //   height: 40,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  width: size.width * 0.8,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.grey)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: const Text(
                                          "City",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: cityDataList
                                            .map<DropdownMenuItem<String>>(
                                              (Map<String, dynamic> item) =>
                                                  DropdownMenuItem<String>(
                                                value: item['name'],
                                                child: Text(item['name']),
                                              ),
                                            )
                                            .toList(),
                                        value: selectedCity,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCity = value.toString();
                                          });
                                        },
                                        // Rest of your DropdownButton2 parameters
                                        // I have omitted as I am not aware of them
                                        // buttonStyleData: const ButtonStyleData(
                                        //   height: 40,
                                        //   width: 140,
                                        // ),
                                        // menuItemStyleData: const MenuItemStyleData(
                                        //   height: 40,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18.0,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  if (bussinesNameController.text.isEmpty ||
                      selectedState == null ||
                      selectedCity == null) {
                    AnimatedSnackBar.rectangle(
                      'Required',
                      "All Field's Are Required.",
                      type: AnimatedSnackBarType.warning,
                      brightness: Brightness.light,
                    ).show(
                      context,
                    );
                  } else {
                    userVerification(phoneController.text,
                        bussinesNameController.text, context);
                  }
                },
                child: isLoging
                    ? const CircularProgressIndicator()
                    : CustomeButton(title: "Submit")),
            const SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  // ---------------------------- StateList -----------------

  // ------------------------------------------------------
  List<Map<String, dynamic>> stateDataList = [];

  Future<void> fetchStateData() async {
    final response =
        await http.get(Uri.parse(Config.baseApi + Config.stateApi));

    if (response.statusCode == 200) {
      stateDataList =
          List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  // ------------------------------------------------------
  List<Map<String, dynamic>> cityDataList = [];

  Future<void> fetchCityData() async {
    final response = await http.get(Uri.parse(Config.baseApi + Config.cityApi));

    if (response.statusCode == 200) {
      cityDataList = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  // -------------------- verification --------

  Future<void> userVerification(
      String mobileNumber, String bussinessname, BuildContext context) async {
    setState(() {
      isLoging = true;
    });
    final response = await http.post(
      Uri.parse(Config.baseApi + Config.userRegisterApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "phone": mobileNumber,
        "whatsapp": widget.phone,
        "fname": bussinesNameController.text,
        "business_name": bussinessname,
        "city": selectedCity.toString(),
        "state": selectedState.toString(),
      }),
    );
    print(response.body);
    var dataa = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);

      setState(() {
        isLoging = false;
      });

      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUpComplete(),
          ));
      print(response.body);
    } else {
      // ignore: use_build_context_synchronously
      AnimatedSnackBar.rectangle(
        'Error',
        "Something Went Wrong.",
        type: AnimatedSnackBarType.warning,
        brightness: Brightness.light,
      ).show(
        context,
      );
      setState(() {
        isLoging = false;
      });

      print(response.body);
    }
  }
}
