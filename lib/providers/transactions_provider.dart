import 'package:bankito/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsProvider extends ChangeNotifier {
  final List<Transaction> _transactionList = [
    Transaction(
        transactionId: DateTime.now().toString(),
        amount: 999.99,
        date: DateTime.now(),
        recipent: 'Basic-fit Netherlands'),
    Transaction(
        transactionId: DateTime.now().toString(),
        amount: 999.99,
        date: DateTime.now(),
        recipent: 'Restaurant'),
    Transaction(
        transactionId: DateTime.now().toString(),
        amount: 999.99,
        date: DateTime.now(),
        recipent: 'Dominik Tyka'),
    Transaction(
        transactionId: DateTime.now().toString(),
        amount: 999.99,
        date: DateTime.now(),
        recipent: 'Prague EPIC club'),
    Transaction(
        transactionId: DateTime.now().toString(),
        amount: 999.99,
        date: DateTime.now(),
        recipent: 'Basic-fit Netherlands'),
    Transaction(
        transactionId: DateTime.now().toString(),
        amount: 999.99,
        date: DateTime.now(),
        recipent: 'Restaurant'),
    Transaction(
        transactionId: DateTime.now().toString(),
        amount: 999.99,
        date: DateTime.now(),
        recipent: 'Dominik Tyka'),
    Transaction(
        transactionId: DateTime.now().toString(),
        amount: 999.99,
        date: DateTime.now(),
        recipent: 'Prague EPIC club'),
  ];

  List<Transaction> get transactionList => [..._transactionList];
}
