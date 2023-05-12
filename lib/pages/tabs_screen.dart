import 'package:bankito/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../services/providers/tabs_provider.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navBar = Provider.of<TabsProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: CustomColors.mainColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
          ),
          toolbarHeight: 0),
      body: navBar.navBarItems[navBar.selectedIndex].screen,
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: navBar.selectedIndex,
          onTap: (i) => navBar.changeIndex = i,
          items: navBar.navBarItems
              .map(
                (e) => BottomNavigationBarItem(
                    icon: e.icon, activeIcon: e.activeIcon, label: e.label),
              )
              .toList()),
    );
  }
}
