import 'package:bankito/user_card_section/cards_page.dart';
import 'package:bankito/home/home_page.dart';
import 'package:bankito/user_transactions_section/transaction_history_page.dart';
import 'package:bankito/theme/colors.dart';
import 'package:flutter/material.dart';

class TabsProvider with ChangeNotifier {
  List<NavbarItem> navBarItems = [
    NavbarItem(
      icon: const Icon(
        Icons.wallet,
        color: Colors.grey,
      ),
      activeIcon: const Icon(
        Icons.wallet,
        color: CustomColors.secondColor,
      ),
      label: 'Home',
      screen: const HomePage(),
    ),
    NavbarItem(
      icon: const Icon(
        Icons.history,
        color: Colors.grey,
      ),
      activeIcon: const Icon(
        Icons.history,
        color: CustomColors.secondColor,
      ),
      label: 'History',
      screen: const TransactionHistoryPage(),
    ),
    NavbarItem(
      icon: const Icon(
        Icons.credit_card,
        color: Colors.grey,
      ),
      activeIcon: const Icon(
        Icons.credit_card,
        color: CustomColors.secondColor,
      ),
      label: 'Cards',
      screen: const CardsPage(),
    ),
    NavbarItem(
      icon: const Icon(
        Icons.currency_exchange,
        color: Colors.grey,
      ),
      activeIcon: const Icon(
        Icons.currency_exchange,
        color: CustomColors.secondColor,
      ),
      label: 'Exchange',
      screen: const HomePage(),
    ),
    NavbarItem(
      icon: const Icon(
        Icons.settings,
        color: Colors.grey,
      ),
      activeIcon: const Icon(
        Icons.settings,
        color: CustomColors.secondColor,
      ),
      label: 'Settings',
      screen: const HomePage(),
    ),
  ];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set changeIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
}

class NavbarItem {
  String label;
  Widget screen;
  Icon icon;
  Icon activeIcon;

  NavbarItem(
      {required this.label,
      required this.icon,
      required this.screen,
      required this.activeIcon});
}
