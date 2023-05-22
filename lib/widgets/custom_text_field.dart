import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?) validateConditions;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Color? iconColor;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? validateMode;

  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText,
      required this.validateConditions,
      this.keyboardType,
      this.prefixIcon,
      this.iconColor,
      this.labelText,
      this.inputFormatters,
      this.validateMode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      autovalidateMode: validateMode ?? AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        color: Colors.white70,
      ),
      controller: controller,
      validator: validateConditions,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: iconColor ?? CustomColors.secondColor,
              )
            : null,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white38),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: CustomColors.secondColor,
          ),
        ),
      ),
    );
  }
}
