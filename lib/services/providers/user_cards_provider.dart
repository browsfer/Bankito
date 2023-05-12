import 'package:bankito/services/functions/database_helper.dart';
import 'package:bankito/services/models/user_card.dart';
import 'package:flutter/material.dart';

class UserCardsProvider extends ChangeNotifier {
  List<UserCard> _userCards = [];

  List<UserCard> get userCards => [..._userCards];

  Future<void> addNewCard(
      {required String name,
      required String? currency,
      required int cardNumber,
      required String expiryDate}) async {
    final newCard = UserCard(
      id: DateTime.now().toString(),
      name: name,
      currency: currency!,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
    );

    _userCards.insert(
      0,
      newCard,
    );
    DBhelper.insert('user_cards', {
      'id': newCard.id,
      'name': newCard.name,
      'currency': newCard.currency,
      'cardNumber': newCard.cardNumber,
      'expiryDate': newCard.expiryDate
    });

    notifyListeners();
  }

  Future<void> fetchCardsData() async {
    final dbData = await DBhelper.getData('user_cards');

    _userCards = dbData
        .map(
          (value) => UserCard(
            id: value['id'],
            name: value['name'],
            currency: value['currency'],
            cardNumber: value['cardNumber'],
            expiryDate: value['expiryDate'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
