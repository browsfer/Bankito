import 'package:bankito/theme/colors.dart';
import 'package:bankito/widgets/user_card.dart';
import 'package:flutter/material.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            children: [
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
              Flexible(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => const UserCard(),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        //ADD CARD button
        ElevatedButton.icon(
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
          onPressed: () {},
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          label: const Text(
            'Add card',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
