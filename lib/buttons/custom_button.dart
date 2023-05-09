import 'package:bankito/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final bool isLime;
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.isLime,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 60,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: isLime ? CustomColors.secondColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
