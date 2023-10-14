import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ecommerce_app/screens/verifications/sign_up_screen.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:ecommerce_app/view/bottom_nav_bar.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:ecommerce_app/widget/custome_button.dart';
import 'package:ecommerce_app/widget/pinPut.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  bool isLoging = false;
  bool isShow = false;
  String otpCode = "";

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSMSListening();
  }

  void startSMSListening() async {
    await SmsAutoFill().listenForCode;
    SmsAutoFill().code.listen((code) {
      setState(() {
        otpController.text = code;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SmsAutoFill().unregisterListener();
    print("unregisterListener");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return orangeColor;
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.12,
                ),
                const Text(
                  "Log In",
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: size.height * 0.12,
                ),
                const Text(
                  "Mobile No.",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                  height: 56,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: phoneController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        filled: true,
                        fillColor: textfiledColor,
                        hintText: "Mobile Number",
                        prefixText: "+91- ",
                        prefixStyle: TextStyle(color: blackColor, fontSize: 16),
                        suffix: isLoading
                            ? CircularProgressIndicator()
                            : TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => AddFieldsScreen(),
                                  //     ));
                                  final signature =
                                      SmsAutoFill().getAppSignature;
                                  print(signature);
                                  sendOTP(context, phoneController.text);
                                },
                                child: Text(
                                  "Send Otp",
                                  style: TextStyle(color: orangeColor),
                                ))),
                  ),
                ),
                isShow
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              sendOTP(context, phoneController.text);
                            },
                            child: Text("Resend")),
                      )
                    : SizedBox(
                        width: 0.0,
                      ),
                const SizedBox(
                  height: 60.0,
                ),
                Center(
                    child: PinPutView(
                  otpController: otpController,
                )),
                const SizedBox(
                  height: 60.0,
                ),
                Center(
                    child: isLoging
                        ? CircularProgressIndicator(
                            color: orangeColor,
                          )
                        : InkWell(
                            onTap: () {
                              loginVerifyOTP(phoneController.text,
                                  otpController.text, context);
                            },
                            child: CustomeButton(
                              title: "Continue",
                            ))),
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("If you don't have an account, then "),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: purpleColor),
                        ))
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

// ------------ login Api ----

  Future<void> sendOTP(BuildContext context, String phoneNumber) async {
    setState(() {
      isLoading = true;
      isShow = true;
    });
    final url = Uri.parse(Config.baseApi + Config.loginOtpApi);

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": phoneNumber}));
    print(response.body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Send Otp success full");
      // startSMSListening();

      AnimatedSnackBar.rectangle(
        'OTP Send',
        'Send Otp To Your Number.',
        type: AnimatedSnackBarType.success,
        brightness: Brightness.light,
      ).show(
        context,
      );
      setState(() {
        isLoading = false;
      });
      // ignore: use_build_context_synchronously
    } else {
      print('Failed to send OTP.');
      // ignore: use_build_context_synchronously
      AnimatedSnackBar.rectangle(
        'Failed to send OTP.',
        data['message'],
        type: AnimatedSnackBarType.warning,
        brightness: Brightness.light,
      ).show(
        context,
      );
      setState(() {
        isLoading = false;
        isShow = false;
      });
      // ignore: use_build_context_synchronously
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     backgroundColor: Colors.yellow,
      //     content: Text(
      //       data['message'],
      //       style: TextStyle(color: Colors.black),
      //     )));
    }
  }

  // ------------------------------------

  Future<void> loginVerifyOTP(
      String mobileNumber, String otp, BuildContext context) async {
    setState(() {
      isLoging = true;
    });
    final response = await http.post(
      Uri.parse(Config.baseApi + Config.loginVerifyApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "phone": mobileNumber,
        "otp": otp,
      }),
    );
    print(response.body);
    var dataa = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("id", data["response"]["id"]);
      prefs.setString("token", data['token']);
      print(data);

      setState(() {
        isLoging = false;
      });

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBarViews(),
          ),
          (route) => false);
      print(response.body);
    } else {
      // ignore: use_build_context_synchronously
      AnimatedSnackBar.rectangle(
        'Failed to Verify OTP.',
        "Invalid OTP",
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
