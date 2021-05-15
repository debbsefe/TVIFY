import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double height(double value) => mediaQuery.size.height * value;
  double width(double value) => mediaQuery.size.width * value;
}

class Height extends StatelessWidget {
  final double height;
  Height(this.height);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class Width extends StatelessWidget {
  final double width;
  Width(this.width);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
