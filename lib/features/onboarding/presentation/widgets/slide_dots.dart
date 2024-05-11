import 'package:flutter/material.dart';
import 'package:tvfiy/core/core.dart';

class SlideDots extends StatelessWidget {
  const SlideDots({required this.isActive, super.key});

  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 4,
      width: 13,
      decoration: BoxDecoration(
        color: isActive ? CustomTheme.primaryColor : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}
