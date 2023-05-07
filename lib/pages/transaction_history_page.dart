// ignore: unused_import
import 'dart:ffi';

import 'package:bankito/providers/transactions_provider.dart';
import 'package:bankito/theme/colors.dart';
import 'package:bankito/widgets/single_transaction.dart';
import 'package:bankito/widgets/transactions_page_button.dart';
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
          height: MediaQuery.of(context).size.height * 0.20,
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
                    TransactionsPageButton(
                      title: 'Period',
                      onTap: () {},
                    ),
                    TransactionsPageButton(
                      title: 'Price',
                      onTap: () {},
                    ),
                    TransactionsPageButton(
                      title: 'Product',
                      onTap: () {},
                    ),
                    TransactionsPageButton(
                      title: 'Type',
                      onTap: () {},
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
