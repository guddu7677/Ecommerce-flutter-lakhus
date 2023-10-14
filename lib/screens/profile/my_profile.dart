import 'dart:convert';
import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ecommerce_app/screens/profile_screen.dart';
import 'package:ecommerce_app/screens/verifications/sign_complet.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:ecommerce_app/widget/custome_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/config.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  String whatsApp;
  String shopName;
  String state;
  String city;
  String img;
  MyProfile(
      {super.key,
      required this.city,
      required this.shopName,
      required this.state,
      required this.whatsApp,
      required this.img});

  @override
  State<MyProfile> createState() => _VerificationProcessState();
}

class _VerificationProcessState extends State<MyProfile> {
  TextEditingController whatsAppController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController staeController = TextEditingController();
  bool isEdit = false;
  bool isLoading = false;
  String? selectedState;
  String? selectedCity;

  // ---------------- image picker --------------

  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No image selected'),
      ));
    } else {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    whatsAppController.text = widget.whatsApp;
    nameController.text = widget.shopName;
    staeController.text = widget.state;
    cityController.text = widget.city;

    fetchStateData().then((_) {
      setState(() {});
    });
    fetchCityData().then((_) {
      setState(() {});
    });
  }

  TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
      ),
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
                            height: size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Profile",
                                style: TextStyle(
                                    fontSize: 38, fontWeight: FontWeight.w600),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEdit = true;
                                    });
                                  },
                                  child: Icon(Icons.edit_outlined))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Center(
                                  child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    color: orangeColor,
                                    borderRadius: BorderRadius.circular(50),
                                    image: _imageFile == null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(widget.img))
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(_imageFile!))),
                              )),
                              SizedBox(
                                height: 5.0,
                              ),
                              isEdit
                                  ? Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          _pickImage(ImageSource.gallery);
                                        },
                                        child: Text("Change Image",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: orangeColor)),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0.0,
                                    )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.06,
                          ),
                          TextField(
                            enabled: isEdit ? true : false,
                            controller: whatsAppController,
                            style: TextStyle(color: blackColor),
                            decoration: InputDecoration(
                                label: Row(
                              children: [
                                Text(
                                  "Whatsapp No.",
                                  style: TextStyle(color: orangeColor),
                                ),
                                const Text(
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
                            controller: nameController,
                            style: TextStyle(color: blackColor),
                            enabled: isEdit ? true : false,
                            decoration: InputDecoration(
                                label: Row(
                              children: [
                                Text("Business/Shop Name",
                                    style: TextStyle(color: orangeColor)),
                                const Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            )),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                       isEdit ?   Row(
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
                                        hint: Text(
                                          widget.state.toString(),
                                          style: TextStyle(
                                              fontSize: 14, color: blackColor),
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
                                        hint: Text(
                                          widget.city.toString(),
                                          style: TextStyle(
                                              fontSize: 14, color: blackColor),
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
                          ):
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: staeController,
                                  style: TextStyle(color: blackColor),
                                  enabled: false,
                                  decoration: InputDecoration(
                                    label: Text("State",
                                        style: TextStyle(color: orangeColor)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: cityController,
                                  style: TextStyle(color: blackColor),
                                  enabled: false,
                                  decoration: InputDecoration(
                                    label: Text("City",
                                        style: TextStyle(color: orangeColor)),
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
            isEdit
                ? InkWell(
                    onTap: () {
                      // profileUpdate();
                      UpdateProfile();
                    },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : CustomeButton(title: "Update"))
                : const SizedBox(
                    height: 15.0,
                  ),
            const SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

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

  UpdateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("id") ?? -1;
    String token = prefs.getString("token") ?? "";
    setState(() {
      isLoading = true;
    });
    try {
      var request = http.MultipartRequest(
        "PUT",
        Uri.parse(
            "${Config.baseApi + Config.profileUpdateApi + id.toString()}/"),
      );
      request.headers["Content-Type"] = "multipart/form-data";
      request.headers["Authorization"] = "Token $token";

      // add other fields to the request
      request.fields["city"] = cityController.text;
      request.fields["fname"] = nameController.text;
      request.fields["whatsapp"] = whatsAppController.text;
      request.fields["phone"] = whatsAppController.text;
      request.fields["state"] = staeController.text;

      // add image to the request
      if (_imageFile != null) {
        var stream = http.ByteStream(_imageFile!.openRead());
        var length = await _imageFile!.length();
        var multipartFile = http.MultipartFile(
          "image",
          stream,
          length,
          filename: (_imageFile!.path),
        );
        request.files.add(multipartFile);
      }

      var response = await request.send().timeout(Duration(seconds: 8));
      if (response.statusCode == 200) {
        print(response.statusCode);
        // ignore: use_build_context_synchronously
        AnimatedSnackBar.rectangle(
          'Profile Updated',
          "Profile Updated Successfully.",
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
        ).show(
          context,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        setState(() {
          isLoading = false;
        });
      } else {
        print("else" + response.reasonPhrase.toString());
        AnimatedSnackBar.rectangle(
          'Failed to Update.',
          "Failed To Update Profile!",
          type: AnimatedSnackBarType.warning,
          brightness: Brightness.light,
        ).show(
          context,
        );
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      AnimatedSnackBar.rectangle(
        'Failed to Update.',
        e.toString(),
        type: AnimatedSnackBarType.warning,
        brightness: Brightness.light,
      ).show(
        context,
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}
