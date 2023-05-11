import 'package:bankito/buttons/dropdown_button.dart';
import 'package:bankito/theme/colors.dart';
import 'package:bankito/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_cards_provider.dart';

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
      //ADD VALIDATION TO FORMS LATER

      Provider.of<UserCardsProvider>(context, listen: false).addNewCard(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose card currency:',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 20),

              //CHOOSE CURRENCY
              CustomDropdownButton(
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
                buttonWidth: 80,
                buttonHeight: 40,
                buttonPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
              ),
            ],
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
          Row(
            children: [
              Flexible(
                //EXPIRY DATE
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
              const SizedBox(width: 40),
              Flexible(
                //CVV
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

          //ADD CARD BUTTON
          const SizedBox(height: 45),
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
