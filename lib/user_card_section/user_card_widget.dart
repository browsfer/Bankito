import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  // final String currency;
  final int cardNumber;
  final String expiryDate;

  const UserCard(
      {required this.name,
      required this.cardNumber,
      required this.expiryDate,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(12),
          ),
          height: 168,
          width: 335,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/bankito_logo.png',
                    scale: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$cardNumber',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text(
                        'Expiry',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        expiryDate,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'CVV',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '***',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
