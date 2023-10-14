import 'package:ecommerce_app/screens/components/about_us.dart';
import 'package:ecommerce_app/screens/components/privacy_policy.dart';
import 'package:ecommerce_app/screens/components/term_&_condition.dart';
import 'package:ecommerce_app/screens/order_history.dart';
import 'package:ecommerce_app/screens/profile/my_profile.dart';
import 'package:ecommerce_app/screens/verifications/sign_up_screen.dart';
import 'package:ecommerce_app/service/profile_service.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileService profileService = ProfileService();
  bool isLoading = true;
  bool isLoggedIn = false;
  String accessToken = "";
  // ------ signOut function----

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("id");
    setState(() {
      isLoggedIn = false;
      accessToken = "";
    });
  }

  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileService.fetchProfileDetailsData().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: profileService.fetchProfileDetailsData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15.0,
                          ),
                          CircleAvatar(
                            backgroundImage: profileService
                                        .profiletDetailsModel!.image ==
                                    null
                                ? const NetworkImage(
                                    "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg")
                                : NetworkImage(profileService
                                    .profiletDetailsModel!.image
                                    .toString()),
                            radius: 40,
                          ),
                          Text(
                            profileService.profiletDetailsModel!.fname
                                .toString(),
                            style: TextStyle(color: purpleColor, fontSize: 20),
                          ),
                          Text(
                            profileService.profiletDetailsModel!.phone
                                .toString(),
                            style: TextStyle(color: blackColor, fontSize: 14),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey,
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 28.0,
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyProfile(
                          whatsApp: profileService
                              .profiletDetailsModel!.whatsapp
                              .toString(),
                          shopName: profileService.profiletDetailsModel!.fname
                              .toString(),
                          city: profileService.profiletDetailsModel!.city
                              .toString(),
                          state: profileService.profiletDetailsModel!.state
                              .toString(),
                          img: profileService.profiletDetailsModel!.image ==
                                  null
                              ? "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"
                              : profileService.profiletDetailsModel!.image
                                  .toString(),
                        ),
                      ));
                },
                leading: Icon(
                  CupertinoIcons.person,
                  color: blackColor,
                ),
                title: const Text("My Profile"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderHistoryScreen(),
                      ));
                },
                leading: Icon(
                  CupertinoIcons.cart,
                  color: blackColor,
                ),
                title: const Text("My Order"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              Divider(
                thickness: 5.0,
                color: Colors.grey[300],
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen(),
                      ));
                },
                leading: Icon(
                  CupertinoIcons.lock_shield,
                  color: blackColor,
                ),
                title: const Text("Privacy Policy"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermAndCondition(),
                      ));
                },
                child: ListTile(
                  leading: Icon(
                    CupertinoIcons.flag_circle,
                    color: blackColor,
                  ),
                  title: const Text("Terms & Condition"),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline,
                  color: blackColor,
                ),
                title: const Text("Get Help"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              const SizedBox(
                height: 8.0,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: whiteColor,
                  title: const Text("Log Out"),
                  content: const Text("Are you sure?"),
                  actions: [
                    TextButton(
                      child: Text("No", style: TextStyle(color: orangeColor)),
                      onPressed: () {
                        Navigator.of(context).pop(); // dismiss the dialog
                      },
                    ),
                    TextButton(
                      child: Text(
                        "Yes",
                        style: TextStyle(color: orangeColor),
                      ),
                      onPressed: () {
                        logOut();

                        if (accessToken == "") {
                          clearUserData();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                              (route) => false);
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: size.width * 0.8,
            height: size.height * 0.06,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffCC0000),
                ),
                borderRadius: BorderRadius.circular(12)),
            child: const Center(
              child: Text("Log Out",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffCC0000),
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ),
    );
  }
}
