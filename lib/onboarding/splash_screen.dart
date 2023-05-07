import 'package:bankito/authentication/auth_form.dart';
import 'package:bankito/onboarding/my_intro_slider.dart';
import 'package:flutter/material.dart';

import '../authentication/auth_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void userAuth(bool isSignIn) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color.fromRGBO(17, 17, 17, 0.95),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) => AuthForm(isSignIn: isSignIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                color: Color.fromRGBO(17, 17, 17, 1),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.80,
              //Slides
              child: const MyIntroSlider(),
            ),
          ),
          // User authentication section
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AuthButton(
                  title: 'Sign in',
                  onTap: () => userAuth(true),
                  isLime: false,
                ),
                AuthButton(
                  title: 'Sign up',
                  onTap: () => userAuth(false),
                  isLime: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
