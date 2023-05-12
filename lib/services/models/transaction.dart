class Transaction {
  final String transactionId;
  final double amount;
  final DateTime date;
  final String recipent;
  final bool isIncome;

  Transaction({
    required this.transactionId,
    required this.amount,
    required this.date,
    required this.recipent,
    required this.isIncome,
  });
}
