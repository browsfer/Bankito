import 'package:bankito/theme/colors.dart';
import 'package:bankito/widgets/transactions_list.dart';
import 'package:bankito/widgets/transactions_page_button.dart';
import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //Page title
          decoration: const BoxDecoration(
            color: CustomColors.mainColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 80),
                const Text(
                  'Transaction History',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 30),
                //Buttons
                Row(
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
                    const TransactionPageButton(title: 'Period'),
                    const TransactionPageButton(title: 'Price'),
                    const TransactionPageButton(title: 'Product'),
                    const TransactionPageButton(title: 'Type'),
                  ],
                ),
              ],
            ),
          ),
        ),
        TransactionList(),
      ],
    );
  }
}
