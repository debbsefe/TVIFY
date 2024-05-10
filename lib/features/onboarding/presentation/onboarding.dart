import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/app_router.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/features/components/buttons.dart';
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

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            onPageChanged: _onPageChanged,
            controller: _pageController,
            itemCount: slideList.length,
            itemBuilder: (ctx, i) => SlideItem(index: i),
          ),
          Positioned(
            bottom: 190,
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
            bottom: 80,
            left: 30,
            right: 35,
            child: CustomButton.icon(
              name: 'Get Started',
              onPressed: () {
                ref
                    .watch(sharedPreferencesRepositoryProvider)
                    .setFirstTimeUser();
                context.router.replace(SignUpRoute(onResult: (value) {}));
              },
              icon: Icons.arrow_forward,
            ),
          ),
        ],
      ),
    );
  }
}
