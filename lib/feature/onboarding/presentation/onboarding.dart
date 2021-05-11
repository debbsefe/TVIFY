import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/core/widgets/buttons.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';
import '../../../theme.dart';
import 'widgets/slide_dots.dart';
import 'widgets/slide_item.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int _currentPage = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  late Timer timer;
  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
    //   if (_currentPage < 2)
    //     _currentPage++;
    //   else
    //     _currentPage = 0;

    //   _pageController.animateToPage(
    //     _currentPage,
    //     duration: Duration(milliseconds: 150),
    //     curve: Curves.linear,
    //   );
    // });
  }

  @override
  void dispose() {
    // timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Stack(children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onPageChanged,
            controller: _pageController,
            itemCount: slideList.length,
            itemBuilder: (ctx, i) => SlideItem(i),
          ),
          Positioned(
              bottom: 160,
              left: 30,
              right: 15,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (int i = 0; i < slideList.length; i++)
                    if (i == _currentPage) SlideDots(true) else SlideDots(false)
                ],
              )),
          Positioned(
            bottom: 60,
            left: 30,
            right: 35,
            child: CustomButton(
              name: "Get Started",
              onPressed: () async {},
            ),
          ),
        ]),
      ),
    );
  }
}
