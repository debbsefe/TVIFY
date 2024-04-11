import 'package:flutter/material.dart';
import 'package:movie_colony/core/theme/theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.name,
    required this.onPressed,
    this.fontSize = 16,
    this.color,
    this.textColor,
    this.height = 55,
    super.key,
  });
  final String name;
  final VoidCallback onPressed;
  final double fontSize;
  final double height;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color ?? CustomTheme.primaryColor500,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          name,
          style: TextStyle(
            color: textColor ?? CustomTheme.buttonColor1,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
