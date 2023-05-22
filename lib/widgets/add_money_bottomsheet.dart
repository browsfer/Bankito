import 'package:bankito/services/providers/user_cards_provider.dart';
import 'package:bankito/utils/colors.dart';
import 'package:bankito/widgets/custom_button.dart';
import 'package:bankito/widgets/custom_text_field.dart';
import 'package:bankito/widgets/user_card_widget.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class AddMoneyBottomsheet extends StatefulWidget {
  const AddMoneyBottomsheet({super.key});

  @override
  State<AddMoneyBottomsheet> createState() => _AddMoneyBottomsheetState();
}

class _AddMoneyBottomsheetState extends State<AddMoneyBottomsheet> {
  final _moneyAmountController = TextEditingController();

  @override
  void dispose() {
    _moneyAmountController.dispose();
    super.dispose();
  }

  void _submitForm() {
    var removeLetters =
        _moneyAmountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    var finalAmount = int.parse(removeLetters);

    Navigator.of(context).pop(finalAmount);
  }

  @override
  Widget build(BuildContext context) {
    final cardsData = Provider.of<UserCardsProvider>(context, listen: false);

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
          const SizedBox(height: 25),
          const Text(
            'Insert amount',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),

          //Adding money
          CustomTextField(
            controller: _moneyAmountController,
            inputFormatters: <TextInputFormatter>[
              CurrencyTextInputFormatter(
                locale: 'en',
                decimalDigits: 0,
                symbol: '\$',
              ),
            ],
            validateMode: AutovalidateMode.always,
            validateConditions: (value) {
              if (value!.isEmpty) {
                return 'Insert amount here';
              }
              return null;
            },
            keyboardType: TextInputType.number,
          ),
          //
          const SizedBox(height: 25),

          const Text(
            'Choose a card',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),

          //Card selection
          Flexible(
            child: FutureBuilder(
              future: Provider.of<UserCardsProvider>(context, listen: false)
                  .fetchCardsData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingAnimationWidget.halfTriangleDot(
                    color: CustomColors.secondColor,
                    size: 50,
                  );
                } else if (cardsData.userCards.isEmpty) {
                  return const Center(
                    child: Text(
                      'You have to add card first!',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 22,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: cardsData.userCards.length,
                    itemBuilder: (context, index) => UserCardWidget(
                      isDismissable: false,
                      id: cardsData.userCards[index].id,
                      name: cardsData.userCards[index].name,
                      currency: cardsData.userCards[index].currency,
                      cardNumber: cardsData.userCards[index].cardNumber,
                      expiryDate: cardsData.userCards[index].expiryDate,
                      cardType: cardsData.userCards[index].cardType,
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 10),

          //Submit button
          CustomButton(
            onPressed: _submitForm,
            borderRadius: BorderRadius.circular(22),
            color: CustomColors.secondColor,
            textColor: CustomColors.mainColor,
            text: 'Add money',
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
