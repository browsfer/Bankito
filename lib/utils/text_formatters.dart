import 'package:flutter/services.dart';

class CreditCardFormatters {
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

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
