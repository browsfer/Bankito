import 'package:bankito/services/functions/database_helper.dart';
import 'package:bankito/services/models/user_card.dart';
import 'package:flutter/material.dart';

class UserCardsProvider extends ChangeNotifier {
  List<UserCard> _userCards = [];

  List<UserCard> get userCards => [..._userCards];

  Future<void> addNewCard({
    required String id,
    required String name,
    required String? currency,
    required int cardNumber,
    required String expiryDate,
    required String? cardType,
  }) async {
    final newCard = UserCard(
      id: id,
      name: name,
      currency: currency!,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardType: cardType!,
    );

    _userCards.insert(
      0,
      newCard,
    );
    DBhelper.insertData('user_cards', {
      'id': newCard.id,
      'name': newCard.name,
      'currency': newCard.currency,
      'cardNumber': newCard.cardNumber,
      'expiryDate': newCard.expiryDate,
      'cardType': newCard.cardType,
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
            cardType: value['cardType'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future removeUserCard(String id) async {
    await DBhelper.deleteUserCard(id);
    _userCards.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
