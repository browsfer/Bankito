import 'package:bankito/models/user_card.dart';
import 'package:flutter/material.dart';

class UserCardsProvider extends ChangeNotifier {
  List<UserCard> _userCards = [];

  List<UserCard> get userCards => [..._userCards];

  void addNewCard(
    String name,
    String currency,
    int cardNumber,
    String expiryDate,
  ) {
    _userCards.insert(
      0,
      UserCard(
          name: name,
          currency: currency,
          cardNumber: cardNumber,
          expiryDate: expiryDate),
    );
    notifyListeners();
  }
}
