import 'package:flutter/material.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.wallet,
            color: Colors.grey,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
            color: Colors.grey,
          ),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.credit_card,
            color: Colors.grey,
          ),
          label: 'Cards',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.currency_exchange,
            color: Colors.grey,
          ),
          label: 'Exchange',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Colors.grey,
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}
