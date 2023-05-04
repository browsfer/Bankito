// ignore_for_file: sort_child_properties_last

import 'package:bankito/bottom_navigation/bottom_nav_bar.dart';
import 'package:bankito/widgets/dropdown_button.dart';
import 'package:bankito/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color _inactiveContainerColor = Color.fromRGBO(17, 17, 17, 1);
  final Color _activeContainerColor = Colors.lightGreen;
  bool _addMoneyContainerSelected = false;
  bool _transactionsContainerSelected = false;

  void selectAddMoney() {
    setState(() {
      _addMoneyContainerSelected = true;
      _transactionsContainerSelected = false;
    });
  }

  void selectTransactions() {
    setState(() {
      _addMoneyContainerSelected = false;
      _transactionsContainerSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavBar(),
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(17, 17, 17, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.50,
            //Upper part
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // User profile picture
                    const CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/profile_avatar.png',
                      ),
                    ),
                    const SizedBox(width: 10),
                    // User name and account info
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Dominik',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Personal account',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Menu
                    MyDropDownButton(),
                  ],
                ),
                const Divider(color: Colors.grey),
                const SizedBox(height: 10),
                // Balance + two big buttons
                Row(
                  children: const [
                    Text(
                      'Balance',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(height: 5),
                Row(children: const [
                  Text(
                    '29,999 USD',
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  Spacer(),
                ]),
                const SizedBox(height: 15),
                Flexible(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: selectAddMoney,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _addMoneyContainerSelected
                                  ? _activeContainerColor
                                  : _inactiveContainerColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            height: 150,
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.attach_money,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Add money',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: selectTransactions,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _transactionsContainerSelected
                                  ? _activeContainerColor
                                  : _inactiveContainerColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            height: 150,
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.money_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Transactions',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 15),

          // Transactions section
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transactions',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Show all',
                    ),
                  )
                ]),
          ),
          //List of transactions
          TransactionList(),
        ],
      ),
    );
  }
}
