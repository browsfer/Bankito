// ignore_for_file: sort_child_properties_last

import 'package:bankito/buttons/custom_button.dart';
import 'package:bankito/navigation/tabs_provider.dart';
import 'package:bankito/user_transactions_section/transactions_provider.dart';
import 'package:bankito/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../user_transactions_section/single_transaction_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void selectAddMoney() async {
    //Navigating to page later
    await FirebaseAuth.instance.signOut();
  }

  void selectTransfer() {
    //Navigating to page later
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: CustomColors.mainColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.45,
          //Upper part
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // User profile picture
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/profile_avatar.png',
                      ),
                    ),
                    SizedBox(width: 10),
                    // User name and account info
                    Column(
                      children: [
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
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(color: Colors.grey),
                const SizedBox(height: 10),
                // Balance
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Balance',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 5),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '29,999 USD',
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ),
                const SizedBox(height: 15),
                //two big buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      onPressed: selectAddMoney,
                      splashColor: CustomColors.secondColor,
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(34, 34, 34, 1),
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: Colors.white,
                            ),
                            Text(
                              'Add money',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ]),
                      textColor: Colors.white,
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(width: 20),
                    CustomButton(
                      onPressed: selectTransfer,
                      borderRadius: BorderRadius.circular(12),
                      color: CustomColors.secondColor,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: CustomColors.mainColor,
                          ),
                          Text('Transfer')
                        ],
                      ),
                      height: 150,
                      width: 150,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),

        // Transactions section
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              'Transactions',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
            Consumer<TabsProvider>(
              builder: (context, value, child) => TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () => value.changeIndex = 1,
                child: const Text(
                  'Show all',
                ),
              ),
            )
          ]),
        ),
        //List of transactions
        Flexible(
          child: Consumer<TransactionsProvider>(
            builder: (context, value, child) => ListView.builder(
              itemCount: value.transactionList.length,
              itemBuilder: (context, index) => SingleTransactionTile(
                amount: value.transactionList[index].amount,
                date: value.transactionList[index].date,
                recipent: value.transactionList[index].recipent,
                isIncome: value.transactionList[index].isIncome,
              ),
            ),
          ),
        )
      ],
    );
  }
}
