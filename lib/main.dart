import 'package:bankito/pages/splash_screen.dart';
import 'package:bankito/pages/transaction_history_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Switzer',
      ),
      debugShowCheckedModeBanner: false,
      home: TransactionHistory(),
      routes: {
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
