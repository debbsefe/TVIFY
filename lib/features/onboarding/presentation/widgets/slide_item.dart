import 'package:flutter/material.dart';
import 'package:movie_colony/core/utils/size_ext.dart';
import 'package:movie_colony/features/onboarding/domain/entities/slides.dart';

class SlideItem extends StatelessWidget {
  const SlideItem({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Height(32),
          Image.asset(
            slideList[index].imageUrl,
          ),
          slideList[index].description,
        ],
      ),
    );
  }
}

class SlideDescription extends StatelessWidget {
  const SlideDescription({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

const String onboarding1 = 'assets/images/onboarding1.png';
const String onboarding2 = 'assets/images/onboarding2.png';
const String onboarding3 = 'assets/images/onboarding3.png';

final slideList = [
  const Slide(
    imageUrl: onboarding1,
    description: SlideDescription(
      text: 'Get notifications on your \nfavourite tv shows',
    ),
  ),
  const Slide(
    imageUrl: onboarding2,
    description: SlideDescription(
      text: 'Create a watchlist of your \nfavourite tv shows',
    ),
  ),
  const Slide(
    imageUrl: onboarding3,
    description: SlideDescription(
      text: 'Get fresh news about your Tv \nshows to keep you in the loop',
    ),
  ),
];
