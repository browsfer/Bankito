import 'package:bankito/auth/auth_form.dart';
import 'package:bankito/widgets/my_intro_slider.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
          Flexible(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    width: 150,
                    height: 80,
                    text: 'Sign in',
                    onPressed: () => userAuth(true),
                  ),
                  CustomButton(
                    width: 150,
                    height: 80,
                    text: 'Sign up',
                    onPressed: () => userAuth(false),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
