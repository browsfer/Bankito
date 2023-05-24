import 'package:bankito/services/providers/transactions_provider.dart';
import 'package:bankito/utils/colors.dart';
import 'package:bankito/widgets/custom_button.dart';
import 'package:bankito/widgets/single_transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  static const routeName = '/transactions-history-page';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //Page title
          decoration: const BoxDecoration(
            color: CustomColors.mainColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Transaction History',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 25),

              //Buttons
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: CustomColors.secondColor,
                      radius: 25,
                      child: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    CustomButton(
                      onPressed: () {},
                      text: 'Product',
                      textSize: 14,
                      padding: const EdgeInsets.all(11),
                      borderRadius: BorderRadius.circular(88),
                      height: 50,
                      width: 90,
                    ),
                    CustomButton(
                      onPressed: () {},
                      text: 'Dates',
                      textSize: 14,
                      padding: const EdgeInsets.all(11),
                      borderRadius: BorderRadius.circular(88),
                      height: 50,
                      width: 90,
                    ),
                    CustomButton(
                      onPressed: () {},
                      text: 'Type',
                      textSize: 14,
                      padding: const EdgeInsets.all(11),
                      borderRadius: BorderRadius.circular(88),
                      height: 50,
                      width: 90,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // List of transactions
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
        ),
      ],
    );
  }
}
