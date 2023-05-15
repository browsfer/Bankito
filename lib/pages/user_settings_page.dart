import 'package:bankito/utils/colors.dart';
import 'package:flutter/material.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColors.mainColor,
      body: Center(
        child: Column(
          children: [
            //Fetch profile picture from firebase
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/profile_avatar.png',
              ),
            ),
            // User name and account info
            Column(
              children: [
                //Fetch name from Firebase
                Text(
                  'Dominik',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                //Fetch email address from Firebase
                Text(
                  'domtyk@okok.pl',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
