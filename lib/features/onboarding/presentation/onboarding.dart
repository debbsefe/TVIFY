import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/app_router.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/core/widgets/buttons.dart';
import 'package:movie_colony/features/onboarding/presentation/widgets/slide_dots.dart';
import 'package:movie_colony/features/onboarding/presentation/widgets/slide_item.dart';

@RoutePage()
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  int _currentPage = 0;

  final PageController _pageController = PageController();

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
      child: Stack(
        children: <Widget>[
          PageView.builder(
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
                    const SlideDots(isActive: false),
              ],
            ),
          ),
          Positioned(
            bottom: 60,
            left: 30,
            right: 35,
            child: CustomButton(
              name: 'Get Started',
              onPressed: () {
                ref
                    .watch(sharedPreferencesRepositoryProvider)
                    .setFirstTimeUser();
                context.router.replace(SignUpRoute(onResult: (value) {}));
              },
            ),
          ),
        ],
      ),
    );
  }
}
