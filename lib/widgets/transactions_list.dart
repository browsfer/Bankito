import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 20,
        itemBuilder: (context, index) {
          return const ListTile(
            leading: Icon(
              Icons.money_off,
              color: Colors.grey,
            ),
            title: Text('Groceries'),
            subtitle: Text('29.04.2022'),
            trailing: Text('-\$455'),
          );
        },
      ),
    );
  }
}
