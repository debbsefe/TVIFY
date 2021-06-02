import 'package:flutter/material.dart';

class Height extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Height(
    this.height,
  );

  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class Width extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Width(
    this.width,
  );

  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
