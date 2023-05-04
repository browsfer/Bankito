import 'package:flutter/material.dart';

class TransactionPageButton extends StatefulWidget {
  final String title;

  const TransactionPageButton({super.key, required this.title});

  @override
  State<TransactionPageButton> createState() => _TransactionPageButtonState();
}

class _TransactionPageButtonState extends State<TransactionPageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          widget.title,
          style: const TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
