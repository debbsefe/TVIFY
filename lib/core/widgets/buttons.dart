import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final double fontSize, height;
  final Color? color, textColor;

  CustomButton(
      {required this.name,
      required this.onPressed,
      this.fontSize = 16,
      this.color,
      this.textColor,
      this.height = 55});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: height,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color ?? CustomTheme.primaryColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          onPressed: onPressed,
          child: Text(
            name,
            style: TextStyle(
                color: textColor ?? CustomTheme.buttonColor1,
                fontSize: fontSize),
          ),
        ));
  }
}
