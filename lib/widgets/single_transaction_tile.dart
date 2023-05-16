import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleTransactionTile extends StatelessWidget {
  final String id;
  final String recipent;
  final DateTime date;
  final double amount;
  final bool isIncome;

  const SingleTransactionTile(
      {required this.recipent,
      required this.date,
      required this.amount,
      required this.isIncome,
      super.key,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEEE, h:mm a').format(date);

    return ListTile(
      leading: isIncome
          ? Image.asset(
              'assets/icons/income_arrow.png',
              scale: 1,
              width: 36,
              height: 36,
            )
          : Image.asset('assets/icons/outcome_arrow.png',
              scale: 1, width: 36, height: 36),
      title: Text(recipent),
      subtitle: Text(formattedDate),
      trailing: Text(isIncome ? '$amount' : '-$amount'),
    );
  }
}
