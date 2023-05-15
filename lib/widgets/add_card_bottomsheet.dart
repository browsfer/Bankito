import 'package:bankito/widgets/custom_dropdown_button.dart';
import 'package:bankito/utils/colors.dart';
import 'package:bankito/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/providers/user_cards_provider.dart';

class AddCardSheet extends StatefulWidget {
  const AddCardSheet({super.key});

  @override
  State<AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<AddCardSheet> {
  final _expiryDateController = TextEditingController();

  final _cardNumberController = TextEditingController();

  final _nameOnCardController = TextEditingController();

  final _cvvController = TextEditingController();

  String? currentCurrency;

  final List<String> _currenciesList = [
    'EUR',
    'PLN',
    'USD',
    'AUD',
    'CZK',
  ];

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
        id: DateTime.now().toString(),
        cardNumber: int.parse(_cardNumberController.text.trim()),
        currency: currentCurrency,
        expiryDate: _expiryDateController.text.trim(),
        name: _nameOnCardController.text.trim(),
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
          CustomDropdownButton(
            hintText: const Text(
              'Choose Currency',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            value: currentCurrency,
            items: _currenciesList
                .map((currencyItem) => DropdownMenuItem(
                      value: currencyItem,
                      child: Text(
                        currencyItem,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (newVal) {
              setState(() {
                currentCurrency = newVal!;
              });
            },
            icon: const Icon(Icons.currency_exchange),
            iconEnabledColor: CustomColors.secondColor,
            borderRadius: BorderRadius.circular(24),
            dropdownColor: CustomColors.mainColor,
            border: Border.all(
              width: 1,
              color: CustomColors.secondColor,
            ),
            buttonWidth: 180,
            buttonHeight: 40,
            buttonPadding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
          ),
          const SizedBox(height: 25),

          //CARD NUMBER
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
          const SizedBox(height: 15),

          //NAME ON THE CARD
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (name) {
              if (name!.isEmpty) {
                return 'This field is required!';
              } else if (name.length < 5) {
                return 'Please insert your full name';
              }
              return null;
            },
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
          const SizedBox(height: 35),
          Flexible(
            //EXPIRY DATE
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please insert your card expiry date';
                } else if (value.length < 5 || value.length > 5) {
                  return 'Please use MM/YY format';
                }
                return null;
              },
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
          const SizedBox(width: 40),

          //ADD CARD BUTTON
          const SizedBox(height: 20),
          CustomButton(
            text: 'Add Card',
            onPressed: addNewCard,
            color: CustomColors.secondColor,
            radius: 99,
            textColor: CustomColors.mainColor,
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
