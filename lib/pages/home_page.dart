import 'package:bankito/services/functions/shared_preferences_service.dart';
import 'package:bankito/widgets/add_money_bottomsheet.dart';
import 'package:bankito/widgets/custom_button.dart';
import 'package:bankito/services/providers/tabs_provider.dart';
import 'package:bankito/services/providers/transactions_provider.dart';
import 'package:bankito/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/single_transaction_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var f = NumberFormat.currency(name: 'en', symbol: '\$');
  String? balanceAsString;

  int startBalance = 0;
  int finalBalance = 0;

  @override
  void initState() {
    super.initState();
    SharedPreferencesService.init();
    loadBalance();
  }

  void loadBalance() async {
    final balance = await SharedPreferencesService.getBalance();
    setState(() {
      finalBalance = balance;
      balanceAsString = f.format(finalBalance);
    });
  }

  void saveBalance(int balance) async {
    await SharedPreferencesService.saveBalance(balance);
  }

  // Navigate to AddMoney bottomsheet
  void selectAddMoney() async {
    final responseValue = await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color.fromRGBO(17, 17, 17, 0.95),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) => const AddMoneyBottomsheet(),
    );

    if (responseValue != null) {
      setState(() {
        finalBalance += responseValue as int;
        balanceAsString = f.format(finalBalance);
      });
      saveBalance(finalBalance);
    }
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
                Align(
                  alignment: Alignment.centerLeft,

                  //Will implement summary from both cards later
                  child: Text(
                    balanceAsString ?? '\$00,000',
                    style: const TextStyle(color: Colors.white, fontSize: 35),
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
                      textColor: Colors.white,
                      height: 150,
                      width: 150,
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
                    ),
                    const SizedBox(width: 20),
                    CustomButton(
                      onPressed: selectTransfer,
                      borderRadius: BorderRadius.circular(12),
                      color: CustomColors.secondColor,
                      height: 150,
                      width: 150,
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
                id: value.transactionList[index].transactionId,
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
