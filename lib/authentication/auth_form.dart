import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../theme/colors.dart';
import 'auth_button.dart';

class AuthForm extends StatefulWidget {
  bool isSignIn;
  AuthForm({required this.isSignIn, super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _usernameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
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
      });
      Navigator.of(context).pop();
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

        //Add username
        if (_usernameController.text.isNotEmpty) {
          await _firestore.collection('users').doc(authResult.user!.uid).set(
            {
              'username': _usernameController.text.trim(),
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              content:
                  CircularProgressIndicator(color: CustomColors.secondColor),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 15,
              right: 15,
              top: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/bankito_logo.png',
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
                const SizedBox(height: 25),

                //Authentication form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (!widget.isSignIn)
                        TextFormField(
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                          controller: _usernameController,
                          validator: (value) {
                            if (value!.length < 3) {
                              return 'Use at least 3 letters';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            hintText: 'Username(optional)',
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your e-mail address.';
                          }
                          return null;
                        },
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
                      const SizedBox(height: 15),
                      //Confirm password
                      if (!widget.isSignIn)
                        TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords dont match';
                            }
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
                        )
                    ],
                  ),
                ),

                //Submit button
                const SizedBox(height: 15),
                AuthButton(
                  title: widget.isSignIn ? 'Sign In' : 'Sign Up',
                  onTap: widget.isSignIn ? signInUser : createNewUser,
                  isLime: true,
                ),
                const SizedBox(height: 15),
              ],
            ),
          );
  }
}
