import 'package:bankito/pages/home_page.dart';
import 'package:bankito/onboarding/login_bottomsheet.dart';
import 'package:bankito/onboarding/my_intro_slider.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void userAuth() {
    showModalBottomSheet(
      backgroundColor: const Color.fromRGBO(17, 17, 17, 0.95),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) => const LoginBottomsheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          //Slides
          Container(
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
          // User authentication section
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: userAuth,
                  style: ButtonStyle(
                    splashFactory: InkRipple.splashFactory,
                    elevation: const MaterialStatePropertyAll(0),
                    backgroundColor: MaterialStatePropertyAll(Colors.grey[200]),
                    fixedSize: const MaterialStatePropertyAll(Size(170, 70)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                // Loggin in or creating user
                ElevatedButton(
                  onPressed: userAuth,
                  style: ButtonStyle(
                    splashFactory: InkRipple.splashFactory,
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.lightGreen),
                    fixedSize: const MaterialStatePropertyAll(Size(170, 70)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
