import 'package:bankito/utils/colors.dart';
import 'package:bankito/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSettingsPage extends StatelessWidget {
  UserSettingsPage({super.key});

  final _currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.mainColor,
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return Padding(
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
                    Text(
                      userData['firstName'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    //Fetch email address from Firebase
                    Text(
                      _currentUser.email!,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                        width: 60,
                        height: 40,
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

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
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('ERROR: ${snapshot.error}'),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
