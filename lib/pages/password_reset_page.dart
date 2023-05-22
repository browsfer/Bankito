// ignore_for_file: use_build_context_synchronously

import 'package:bankito/utils/colors.dart';
import 'package:bankito/widgets/custom_button.dart';
import 'package:bankito/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _passwordResetController = TextEditingController();

  @override
  void dispose() {
    _passwordResetController.dispose();

    super.dispose();
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  Future resetUserPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _passwordResetController.text.trim());
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          backgroundColor: Colors.transparent,
          title: Text('Check your mailbox!'),
          content: Text('Email has been sent'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 0,
          backgroundColor: CustomColors.mainColor,
          title: const Text(
            'There was a problem',
            style: TextStyle(color: Colors.grey),
          ),
          content: Text(
            e.message!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: CustomColors.mainColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/bankito_logo.png',
            ),
            const SizedBox(height: 30),

            //EMAIL INPUT
            CustomTextField(
              hintText: 'Your email address',
              validateConditions: validateEmail,
              prefixIcon: Icons.email,
            ),
            const SizedBox(height: 20),
            CustomButton(
              width: 170,
              height: 70,
              text: 'Reset password',
              textColor: Colors.black,
              onPressed: resetUserPassword,
              color: CustomColors.secondColor,
            ),
          ],
        )),
      ),
    );
  }
}
