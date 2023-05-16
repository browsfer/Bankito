import 'package:bankito/services/providers/user_cards_provider.dart';
import 'package:bankito/utils/colors.dart';
import 'package:bankito/widgets/custom_button.dart';
import 'package:bankito/widgets/user_card_widget.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          TextFormField(
            controller: _moneyAmountController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.secondColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.secondColor,
                ),
              ),
            ),
            inputFormatters: <TextInputFormatter>[
              CurrencyTextInputFormatter(
                locale: 'en',
                decimalDigits: 0,
                symbol: '\$',
              ),
            ],
            keyboardType: TextInputType.number,
          ),
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
              builder: (context, snapshot) => Consumer<UserCardsProvider>(
                builder: (context, userCard, child) => ListView.builder(
                  itemCount: userCard.userCards.length,
                  itemBuilder: (context, index) => UserCardWidget(
                    id: userCard.userCards[index].id,
                    name: userCard.userCards[index].name,
                    currency: userCard.userCards[index].currency,
                    cardNumber: userCard.userCards[index].cardNumber,
                    expiryDate: userCard.userCards[index].expiryDate,
                    cardType: userCard.userCards[index].cardType,
                  ),
                ),
              ),
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
