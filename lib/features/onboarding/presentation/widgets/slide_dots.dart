import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  final bool isActive;
  SlideDots(this.isActive);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        curve: Curves.ease,
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4),
        height: isActive ? 5 : 3,
        width: isActive ? 25 : 15,
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).primaryColor
              : Color.fromRGBO(128, 96, 102, 0.56),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ));
  }
}
