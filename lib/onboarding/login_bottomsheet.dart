import 'package:flutter/material.dart';

import '../pages/home_page.dart';

class LoginBottomsheet extends StatelessWidget {
  const LoginBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            },
            icon: const Icon(
              Icons.login,
              color: Colors.white,
            ),
          ),
          RichText(
              text: const TextSpan(children: [
            TextSpan(text: 'Log me in', style: TextStyle(fontSize: 24)),
          ]))
        ],
      ),
    );
  }
}
