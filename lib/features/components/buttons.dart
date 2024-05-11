import 'package:flutter/material.dart';
import 'package:tvfiy/core/theme/theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.name,
    required this.onPressed,
    this.fontSize = 16,
    this.color,
    this.textColor,
    this.height = 55,
    this.icon,
    super.key,
  });

  const factory CustomButton.icon({
    required String name,
    required VoidCallback onPressed,
    required IconData icon,
    Key? key,
    double fontSize,
    double height,
    Color? color,
    Color? textColor,
  }) = _CustomButtonWithIcon;
  final String name;
  final VoidCallback onPressed;
  final double fontSize;
  final double height;
  final Color? color;
  final Color? textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color ?? CustomTheme.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                color: textColor ?? CustomTheme.buttonColor1,
                fontSize: fontSize,
              ),
            ),
            const SizedBox(width: 10),
            if (icon != null)
              Icon(
                icon,
                color: textColor ?? CustomTheme.buttonColor1,
              ),
          ],
        ),
      ),
    );
  }
}

class _CustomButtonWithIcon extends CustomButton {
  const _CustomButtonWithIcon({
    required super.name,
    required super.onPressed,
    required IconData super.icon,
    super.fontSize,
    super.height,
    super.color,
    super.textColor,
    super.key,
  });
}
