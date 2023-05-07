import 'package:bankito/providers/tabs_provider.dart';
import 'package:bankito/navigation/tabs_screen.dart';
import 'package:bankito/onboarding/splash_screen.dart';
import 'package:bankito/pages/transaction_history_page.dart';
import 'package:bankito/providers/transactions_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => TransactionsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TabsProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Switzer',
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TabsScreen();
            } else {
              return SplashScreen();
            }
          },
        ),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          TransactionHistoryPage.routeName: (context) =>
              TransactionHistoryPage(),
        },
      ),
    );
  }
}
