import 'package:bankito/auth/onboarding_screen.dart';
import 'package:bankito/services/providers/tabs_provider.dart';
import 'package:bankito/pages/tabs_screen.dart';
import 'package:bankito/services/providers/user_cards_provider.dart';
import 'package:bankito/pages/transaction_history_page.dart';
import 'package:bankito/services/providers/transactions_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Forcing portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => TransactionsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TabsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserCardsProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Switzer',
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //Temporary untill app finished
              return const TabsScreen();
            } else {
              return const OnboardingScreen();
            }
          },
        ),
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          TransactionHistoryPage.routeName: (context) =>
              const TransactionHistoryPage(),
        },
      ),
    );
  }
}
