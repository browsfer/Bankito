import 'package:bankito/theme/colors.dart';
import 'package:bankito/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_cards_provider.dart';

class AddCardSheet extends StatefulWidget {
  AddCardSheet({super.key});

  @override
  State<AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<AddCardSheet> {
  final _expiryDateController = TextEditingController();

  final _cardNumberController = TextEditingController();

  final _nameOnCardController = TextEditingController();

  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _expiryDateController.dispose();
    _cardNumberController.dispose();
    _nameOnCardController.dispose();
    _cvvController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Add card to CardsProvider list
    void addNewCard() {
      Provider.of<UserCardsProvider>(context, listen: false).addNewCard(
        _nameOnCardController.text.trim(),
        'CVV',
        int.parse(_cardNumberController.text.trim()),
        _expiryDateController.text.trim(),
      );
      Navigator.of(context).pop();
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 15,
        right: 15,
        top: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Image.asset(
              'assets/images/bankito_logo.png',
              scale: 1,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Add your card',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 25),
          TextFormField(
            controller: _cardNumberController,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: Colors.white70,
            ),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.credit_card),
              prefixIconColor: CustomColors.secondColor,
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              hintText: 'Card number',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.secondColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: _nameOnCardController,
            keyboardType: TextInputType.name,
            style: const TextStyle(
              color: Colors.white70,
            ),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              prefixIconColor: CustomColors.secondColor,
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              hintText: 'Name on the card',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.secondColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 35),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: _expiryDateController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: CustomColors.secondColor,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    hintText: 'Expiry date',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.secondColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40),
              Flexible(
                child: TextFormField(
                  controller: _cvvController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: CustomColors.secondColor,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    hintText: 'CVV',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.secondColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 45),
          CustomButton(
            title: 'Add Card',
            onTap: addNewCard,
            isLime: true,
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
