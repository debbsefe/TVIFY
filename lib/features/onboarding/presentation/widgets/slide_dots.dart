import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  const SlideDots({required this.isActive, Key? key}) : super(key: key);

  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        curve: Curves.ease,
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: isActive ? 5 : 3,
        width: isActive ? 25 : 15,
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).primaryColor
              : const Color.fromRGBO(128, 96, 102, 0.56),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ));
  }
}
