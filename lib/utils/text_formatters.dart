import 'package:flutter/services.dart';

class CreditCardFormatters {
  static TextEditingValue formatCreditCardNumber(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final formattedValue = _getFormattedCreditCardNumber(newValue.text);
    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  static String _getFormattedCreditCardNumber(String input) {
    final digitsOnly = input.replaceAll(RegExp(r'\D'), '');
    final List<String> groups = [];
    for (int i = 0; i < digitsOnly.length; i += 4) {
      final endIndex = i + 4;
      final group = digitsOnly.substring(i, endIndex);
      groups.add(group);
    }
    return groups.join(' ');
  }

  static TextEditingValue formatExpiryDate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final formattedValue = _getFormattedExpiryDate(newValue.text);
    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  static String _getFormattedExpiryDate(String input) {
    final digitsOnly = input.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length > 4) {
      return digitsOnly.substring(0, 4);
    }
    if (digitsOnly.length >= 3) {
      final month = digitsOnly.substring(0, 2);
      final year = digitsOnly.substring(2);
      return '$month/$year';
    }
    return digitsOnly;
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return CreditCardFormatters.formatExpiryDate(oldValue, newValue);
  }
}

class CreditCardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return CreditCardFormatters.formatCreditCardNumber(oldValue, newValue);
  }
}
