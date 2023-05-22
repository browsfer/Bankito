import 'package:bankito/pages/password_reset_page.dart';
import 'package:bankito/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/colors.dart';
import '../widgets/custom_button.dart';

class AuthForm extends StatefulWidget {
  final bool isSignIn;

  const AuthForm({required this.isSignIn, Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _surnameController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  Future<void> signInUser() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isLoading = true;
        });
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).colorScheme.error,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } finally {
        setState(() {
          isLoading = false;
          Navigator.of(context).pop();
        });
      }
    }
  }

  Future<void> createNewUser() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isLoading = true;
        });
        final authResult = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (_firstNameController.text.isNotEmpty) {
          await _firestore.collection('users').doc(authResult.user!.uid).set(
            {
              'firstName': _firstNameController.text.trim(),
              'surname': _surnameController.text.trim(),
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).colorScheme.error,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 15,
        right: 15,
        top: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Image.asset(
              'assets/images/bankito_logo.png',
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.isSignIn
                ? 'Welcome back, you have been missed!'
                : 'Create your account',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15),
          Form(
            key: _formKey,
            child: Column(
              children: [
                if (!widget.isSignIn) ...[
                  CustomTextField(
                    controller: _firstNameController,
                    hintText: 'First name',
                    validateConditions: (value) {
                      if (value!.isEmpty) {
                        return 'Please write your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: _surnameController,
                    hintText: 'Surname',
                    validateConditions: (value) {
                      if (value!.length < 3 || value.isEmpty) {
                        return 'Please insert your surname';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                ],
                CustomTextField(
                    controller: _emailController,
                    hintText: 'Email address',
                    validateConditions: validateEmail),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  validateConditions: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    } else if (value.length < 6) {
                      return 'Password should be at least 6 characters long!';
                    }
                    return null;
                  },
                ),
                if (widget.isSignIn) ...[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PasswordResetPage(),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
                if (!widget.isSignIn) ...[
                  CustomTextField(
                    hintText: 'Confirm password',
                    validateConditions: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords don\'t match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ],
            ),
          ),
          const SizedBox(height: 15),
          Flexible(
            child: isLoading
                ? LoadingAnimationWidget.dotsTriangle(
                    color: CustomColors.secondColor,
                    size: 35,
                  )
                : CustomButton(
                    textColor: CustomColors.mainColor,
                    text: widget.isSignIn ? 'Sign In' : 'Sign Up',
                    onPressed: widget.isSignIn ? signInUser : createNewUser,
                    color: CustomColors.secondColor,
                  ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
