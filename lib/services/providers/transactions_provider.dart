import 'package:bankito/services/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsProvider extends ChangeNotifier {
  final List<Transaction> _transactionList = [
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 999.99,
      date: DateTime.now(),
      recipent: 'Basic-fit Netherlands',
      isIncome: false,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 821.99,
      date: DateTime.now(),
      recipent: 'Restaurant',
      isIncome: true,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 13.99,
      date: DateTime.now(),
      recipent: 'Dominik Tyka',
      isIncome: true,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 22.99,
      date: DateTime.now(),
      recipent: 'Prague EPIC club',
      isIncome: false,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 111.99,
      date: DateTime.now(),
      recipent: 'Basic-fit Netherlands',
      isIncome: false,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 123.99,
      date: DateTime.now(),
      recipent: 'Restaurant',
      isIncome: false,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 321.99,
      date: DateTime.now(),
      recipent: 'Dominik Tyka',
      isIncome: true,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 333.99,
      date: DateTime.now(),
      recipent: 'Prague EPIC club',
      isIncome: false,
    ),
  ];

  List<Transaction> get transactionList => [..._transactionList];
}
