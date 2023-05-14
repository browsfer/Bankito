import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final Widget? child;

  final String? value;
  final TextStyle? textStyle;
  final List<DropdownMenuItem<String>> items;
  final Icon? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final bool? isDense;
  final int? elevation;
  final Color? dropdownColor;
  final BorderRadius? borderRadius;
  final Function(String?) onChanged;
  final BoxBorder? border;
  final double? buttonWidth;
  final double? buttonHeight;
  final EdgeInsets? buttonPadding;
  final Text? hintText;

  const CustomDropdownButton(
      {super.key,
      required this.items,
      this.icon,
      this.iconSize,
      this.isDense,
      this.elevation,
      this.dropdownColor,
      this.borderRadius,
      required this.onChanged,
      this.textStyle,
      required this.value,
      this.iconEnabledColor,
      this.border,
      this.buttonWidth,
      this.buttonHeight,
      this.buttonPadding,
      this.hintText,
      this.child});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        padding: buttonPadding,
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(border: border, borderRadius: borderRadius),
        child: DropdownButton(
          hint: hintText,
          value: value,
          style: textStyle,
          icon: icon,
          iconSize: iconSize ?? 24,
          iconEnabledColor: iconEnabledColor,
          isDense: isDense ?? false,
          elevation: elevation ?? 8,
          dropdownColor: dropdownColor,
          borderRadius: borderRadius,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
