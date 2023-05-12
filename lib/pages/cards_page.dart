import 'package:bankito/utils/colors.dart';
import 'package:bankito/widgets/add_card_bottomsheet.dart';
import 'package:bankito/widgets/user_card_widget.dart';
import 'package:bankito/services/providers/user_cards_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    void addUserCard() {
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: const Color.fromRGBO(17, 17, 17, 0.95),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) => AddCardSheet(),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            color: CustomColors.mainColor,
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              //Title
              const Text(
                'Your Cards',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),

              //User cards
              FutureBuilder(
                future: Provider.of<UserCardsProvider>(context, listen: false)
                    .fetchCardsData(),
                builder: (ctx, snapshot) => snapshot.connectionState ==
                        ConnectionState.waiting
                    ? Center(
                        child: LoadingAnimationWidget.halfTriangleDot(
                          color: CustomColors.secondColor,
                          size: 40,
                        ),
                      )
                    : Flexible(
                        child: Consumer<UserCardsProvider>(
                          builder: (context, userCards, child) => userCards
                                  .userCards.isEmpty
                              ? const Center(
                                  child: Text(
                                    'Add your first card!',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: userCards.userCards.length,
                                  itemBuilder: (context, index) => UserCard(
                                    name: userCards.userCards[index].name,
                                    currency:
                                        userCards.userCards[index].currency,
                                    cardNumber:
                                        userCards.userCards[index].cardNumber,
                                    expiryDate:
                                        userCards.userCards[index].expiryDate,
                                  ),
                                ),
                        ),
                      ),
              )
            ],
          ),
        ),

        //ADD CARD button
        Flexible(
          child: ElevatedButton.icon(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              padding: const MaterialStatePropertyAll(
                EdgeInsets.all(20),
              ),
              backgroundColor:
                  const MaterialStatePropertyAll(CustomColors.secondColor),
            ),
            onPressed: addUserCard,
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            label: const Text(
              'Add card',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox()
      ],
    );
  }
}
