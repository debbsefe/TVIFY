import 'package:flutter/material.dart';
import 'package:movie_colony/core/utils/extensions.dart';
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
          Image.asset(
            slideList[index].imageUrl,
            fit: BoxFit.fill,
            height: context.height(0.6),
            width: context.width(1),
          ),
          const Height(20),
          slideList[index].description,
        ],
      ),
    );
  }
}

class SlideDescription extends StatelessWidget {
  const SlideDescription({required this.text1, required this.text2, super.key});

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            text2,
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

const String onboarding1text1 = 'Get notifications on your';
const String onboarding1text2 = 'favourite tv shows';

const String onboarding2text1 = 'Create a watchlist of your';

const String onboarding3text1 = 'Get fresh news about your Tv';
const String onboarding3text2 = 'shows to keep you in the loop';

final slideList = [
  const Slide(
      imageUrl: onboarding1,
      description: SlideDescription(
        text1: onboarding1text1,
        text2: onboarding1text2,
      ),),
  const Slide(
      imageUrl: onboarding2,
      description: SlideDescription(
        text1: onboarding2text1,
        text2: onboarding1text2,
      ),),
  const Slide(
      imageUrl: onboarding3,
      description: SlideDescription(
        text1: onboarding3text1,
        text2: onboarding3text2,
      ),),
];
