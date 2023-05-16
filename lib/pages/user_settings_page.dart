import 'package:bankito/utils/colors.dart';
import 'package:bankito/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.mainColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            //Fetch profile picture from firebase
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/profile_avatar.png',
              ),
            ),
            // User name and account info
            const Text(
              'Dominik',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            //Fetch email address from Firebase
            const Text(
              'domtyk@okok.pl',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 50),

            //Security tab
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Security',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            //Block the card
            CustomButton(
              color: CustomColors.secondColor,
              padding: const EdgeInsets.all(20),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.block),
                  SizedBox(width: 5),
                  Text(
                    'Block the Card',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //Change account password
            CustomButton(
              color: CustomColors.secondColor,
              padding: const EdgeInsets.all(20),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.key),
                  SizedBox(width: 5),
                  Text(
                    'Change password',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your spendings',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
