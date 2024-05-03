import 'package:flutter/material.dart';
import 'package:movie_colony/core/core.dart';

class SlideDots extends ConsumerWidget {
  const SlideDots({required this.isActive, super.key});

  final bool isActive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 4,
      width: 13,
      decoration: BoxDecoration(
        color: dotColor(ref: ref, isActive: isActive),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}

Color dotColor({
  required WidgetRef ref,
  required bool isActive,
}) {
  final theme = ref.watch(themeProvider);

  switch (isActive) {
    case true:
      return theme.primaryColor;
    case false:
      return theme == CustomTheme.lightThemeData
          ? const Color.fromRGBO(128, 96, 102, 0.56)
          : Colors.white;
  }
}
