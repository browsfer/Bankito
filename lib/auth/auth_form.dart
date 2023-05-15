// ignore_for_file: must_be_immutable

import 'package:bankito/pages/password_reset_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/colors.dart';
import '../widgets/custom_button.dart';

class AuthForm extends StatefulWidget {
  bool isSignIn;
  AuthForm({required this.isSignIn, super.key});

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
    super.dispose();
  }

  // Login user
  Future signInUser() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          isLoading = true;
        });
        await _auth.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
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
      }
      setState(() {
        isLoading = false;
        Navigator.of(context).pop();
      });
    }
  }

//Create new user
  Future createNewUser() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      try {
        setState(() {
          isLoading = true;
        });
        final authResult = await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        //Add user data
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
      }
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
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

          //Authentication form
          Form(
            key: _formKey,
            child: Column(
              children: [
                if (!widget.isSignIn)

                  //User first name
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                    controller: _firstNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please insert your name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'First name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white38),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.secondColor,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
                if (!widget.isSignIn)

                  //User surname
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                    controller: _surnameController,
                    validator: (value) {
                      if (value!.length < 3 || value.isEmpty) {
                        return 'Please insert your surname';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'Surname',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white38),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.secondColor,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 15),

                //User email
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    hintText: 'Email address',
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.secondColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white38),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.secondColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                //User password
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    } else if (value.length < 6) {
                      return 'Password should be at least 6 characters long!';
                    }
                    return null;
                  },
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.secondColor,
                      ),
                    ),
                  ),
                ),

                //PASSWORD RESET
                if (widget.isSignIn)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasswordResetPage(),
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
                //Confirm password
                if (!widget.isSignIn)
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords dont match';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: 'Confirm password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white38),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustomColors.secondColor,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 15),
              ],
            ),
          ),

          //Submit button
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
