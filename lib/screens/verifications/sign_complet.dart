import 'package:ecommerce_app/screens/verifications/login_page.dart';
import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/material.dart';

class SignUpComplete extends StatelessWidget {
  const SignUpComplete({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/Rectangle 503.jpg"))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: size.width * 0.9,
                height: size.height * 0.45,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(colors: [
                      Colors.black,
                      Colors.black,
                      Colors.black,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    boxShadow: []),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 14.0,
                      ),
                      const Text(
                        "       Congratulations on\n  successfully creating an\n        account with us!❤️‍🔥",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                              (route) => false);
                        },
                        child: Container(
                          width: size.width * 0.7,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(16)),
                          child: const Center(
                            child: Text("Your Account will Verify soon",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      const Text(
                        "Welcome to our online community at STYLE . H! You're now part of our growing family, and we're thrilled to have you on board.",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 28.0,
              )
            ],
          )),
    );
  }
}
