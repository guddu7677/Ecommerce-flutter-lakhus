import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'service/cart_provider.dart';
import 'view/bottom_nav_bar.dart';
import 'view/onboarding_Screen.dart';
import 'widget/color.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  bool isLoggedIn = false;
  bool showOnboardingScreen = true;
  String? id;
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('token')) {
      setState(() {
        isLoading = false;
        isLoggedIn = true;
        //pref.setString("token", json["token"]);
        id = prefs.getString("token");
        showOnboardingScreen = false;
        print(id);
      });
    } else {
      setState(() {
        isLoading = false;
        isLoggedIn = false;
        showOnboardingScreen = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NoScreenshot.instance.screenshotOff();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lekhus',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: orangeColor),
            useMaterial3: true,
          ),
          home: EasySplashScreen(
            logo: Image.asset('assets/logo.png'),
            logoWidth: 160,
            backgroundColor: Colors.white,
            showLoader: false,
            navigator: isLoggedIn
                ? const BottomNavBarViews()
                : const onBoardingScreen(),
            durationInSeconds: 4,
          )),
    );
  }
}
