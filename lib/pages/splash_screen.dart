import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          //Logo
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: Color.fromRGBO(17, 17, 17, 1),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.85,
            //Slides
            child: Center(child: const Text('ss')),
          ),
          // User authentication section
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightGreen),
                    fixedSize: MaterialStatePropertyAll(Size(170, 70)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                  child: const Text('Log In'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightGreen),
                    fixedSize: MaterialStatePropertyAll(Size(170, 70)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                  child: const Text('Log In'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
