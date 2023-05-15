import 'package:bankito/services/functions/database_helper.dart';
import 'package:bankito/services/providers/user_cards_provider.dart';
import 'package:bankito/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCardWidget extends StatefulWidget {
  final String id;
  final String name;
  final String currency;
  final int cardNumber;
  final String expiryDate;

  const UserCardWidget({
    required this.id,
    required this.name,
    required this.currency,
    required this.cardNumber,
    required this.expiryDate,
    super.key,
  });

  @override
  State<UserCardWidget> createState() => _UserCardWidgetState();
}

class _UserCardWidgetState extends State<UserCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            Provider.of<UserCardsProvider>(context, listen: false)
                .removeUserCard(widget.id);
          },
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shadowColor: CustomColors.secondColor,
                  elevation: 5,
                  title: const Text("Confirm"),
                  content:
                      const Text("Are you sure you wish to delete this card?"),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("DELETE")),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("CANCEL"),
                    ),
                  ],
                );
              },
            );
          },
          background: Container(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete_forever,
              color: Theme.of(context).colorScheme.error,
              size: 50,
            ),
          ),
          direction: DismissDirection.endToStart,
          child: Container(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${widget.cardNumber}',
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
                          widget.expiryDate,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Card currency:',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.currency,
                        style: const TextStyle(
                            color: CustomColors.secondColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
