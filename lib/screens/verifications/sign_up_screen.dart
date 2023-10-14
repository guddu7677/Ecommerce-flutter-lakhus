// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:ecommerce_app/screens/components/term_&_condition.dart';
import 'package:ecommerce_app/screens/verifications/login_page.dart';
import 'package:ecommerce_app/screens/verifications/verification_process.dart';
import 'package:ecommerce_app/service/config.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:ecommerce_app/widget/custome_button.dart';
import 'package:ecommerce_app/widget/pinPut.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isChecked = false;
  bool isLoading = false;
  bool isLoging = false;
  bool isShow = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

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
                  "Sign Up",
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
                    controller: phoneController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.phone,
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
                        hintText: " Mobile Number",
                        prefixText: "+91 ",
                        prefixStyle: TextStyle(color: blackColor, fontSize: 16),
                        suffix: isLoading
                            ? const CircularProgressIndicator()
                            : TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => AddFieldsScreen(),
                                  //     ));
                                  sendOTP(phoneController.text);
                                },
                                child: Text(
                                  "Send Otp",
                                  style: TextStyle(color: blackColor),
                                ))),
                  ),
                ),
                isShow
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              sendOTP(phoneController.text);
                            },
                            child: Text("Resend")))
                    : SizedBox(
                        height: 0.0,
                      ),
                const SizedBox(
                  height: 55.0,
                ),
                Center(
                    child: PinPutView(
                  otpController: otpController,
                )),
                const SizedBox(
                  height: 60.0,
                ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        side: BorderSide(width: 1, color: orangeColor),
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Row(
                        children: [
                          const Text(
                            'I agree with the ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.3333333333,
                              color: Color(0xff354665),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TermAndCondition(),));
                            },
                            child: Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.3333333333,
                                color: orangeColor,
                              ),
                            ),
                          ),
                          const Text(
                            ' and ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.3333333333,
                              color: Color(0xff354665),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Text(
                    'Privacy Policy.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.3333333333,
                      color: orangeColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28.0,
                ),
                Center(
                    child: isLoging
                        ? CircularProgressIndicator()
                        : InkWell(
                            onTap: () {
                              if (phoneController.text.isEmpty) {
                                AnimatedSnackBar.rectangle(
                                  'Enter Phone Number.',
                                  "Please Enter Your Mobile Number",
                                  type: AnimatedSnackBarType.warning,
                                  brightness: Brightness.light,
                                ).show(
                                  context,
                                );
                              } else if (isChecked == false) {
                                AnimatedSnackBar.rectangle(
                                  'Accept',
                                  "Please Accept Term & Condition And Privacy Policy.",
                                  type: AnimatedSnackBarType.warning,
                                  brightness: Brightness.light,
                                ).show(
                                  context,
                                );
                              } else {
                                signUpVerifyOTP(phoneController.text,
                                    otpController.text, context);
                              }
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
                    const Text("If you have already account, then "),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ));
                        },
                        child: Text(
                          "Log In",
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

  // ---------------- Sugn Up -----------------

  Future<void> sendOTP(String phoneNumber) async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(Config.baseApi + Config.signSendApi);

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": phoneNumber}));
    print(response.body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Send Otp success full");
      // _listenOtp();
      AnimatedSnackBar.rectangle(
        'OTP Send',
        data['message'],
        type: AnimatedSnackBarType.success,
        brightness: Brightness.light,
      ).show(
        context,
      );
      setState(() {
        isLoading = false;
        isShow = true;
      });
    } else {
      AnimatedSnackBar.rectangle(
        'Failed to send OTP.',
        data['message'],
        type: AnimatedSnackBarType.warning,
        brightness: Brightness.light,
      ).show(
        context,
      );
      print('Failed to send OTP.');
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

  Future<void> signUpVerifyOTP(
      String mobileNumber, String otp, BuildContext context) async {
    setState(() {
      isLoging = true;
    });
    final response = await http.post(
      Uri.parse(Config.baseApi + Config.signVerifyApi),
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

      setState(() {
        isLoging = false;
      });

      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VerificationProcess(phone: phoneController.text),
          ));
      print(response.body);
    } else {
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
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     backgroundColor: Colors.yellow,
      //     content: Text(
      //       "Something Went Wrong",
      //       style: const TextStyle(
      //           color: Colors.black, fontWeight: FontWeight.bold),
      //     )));
      print(response.body);
    }
  }
}
