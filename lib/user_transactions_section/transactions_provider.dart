import 'package:bankito/models/transaction.dart';
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
      amount: 999.99,
      date: DateTime.now(),
      recipent: 'Restaurant',
      isIncome: true,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 999.99,
      date: DateTime.now(),
      recipent: 'Dominik Tyka',
      isIncome: true,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 999.99,
      date: DateTime.now(),
      recipent: 'Prague EPIC club',
      isIncome: false,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 999.99,
      date: DateTime.now(),
      recipent: 'Basic-fit Netherlands',
      isIncome: false,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 999.99,
      date: DateTime.now(),
      recipent: 'Restaurant',
      isIncome: false,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 999.99,
      date: DateTime.now(),
      recipent: 'Dominik Tyka',
      isIncome: true,
    ),
    Transaction(
      transactionId: DateTime.now().toString(),
      amount: 999.99,
      date: DateTime.now(),
      recipent: 'Prague EPIC club',
      isIncome: false,
    ),
  ];

  List<Transaction> get transactionList => [..._transactionList];
}
