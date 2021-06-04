import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/widgets/buttons.dart';
import 'widgets/slide_dots.dart';
import 'widgets/slide_item.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

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

    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: <Widget>[
        PageView.builder(
          scrollDirection: Axis.horizontal,
          onPageChanged: _onPageChanged,
          controller: _pageController,
          itemCount: slideList.length,
          itemBuilder: (ctx, i) => SlideItem(index: i),
        ),
        Positioned(
            bottom: 160,
            left: 30,
            right: 15,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (int i = 0; i < slideList.length; i++)
                  if (i == _currentPage)
                    const SlideDots(isActive: true)
                  else
                    const SlideDots(isActive: false)
              ],
            )),
        Positioned(
          bottom: 60,
          left: 30,
          right: 35,
          child: CustomButton(
            name: 'Get Started',
            onPressed: () async {
              //context.read(categoriesProvider.notifier).fetchCategory();
            },
          ),
        ),
        // Consumer(builder: (context, watch, child) {
        //   var state = watch(categoriesProvider);
        //   if (state is CategoriesInitial) {
        //     print('initial');
        //     return Container();
        //   } else if (state is CategoriesLoading) {
        //     print('loading');

        //     return Container();
        //   } else if (state is CategoriesLoaded) {
        //     print('loaded ${state.categories}');

        //     return Container();
        //   } else if (state is CategoriesError) {
        //     print('error ${state.message}');
        //     return Container();
        //   }
        //   return Container();
        // }),
      ]),
    );
  }
}
