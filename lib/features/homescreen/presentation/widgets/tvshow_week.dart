import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/cache/cache_image.dart';
import 'package:movie_colony/core/widgets/buttons.dart';
import 'package:movie_colony/features/trending/domain/entities/trending.dart';
import 'package:movie_colony/features/trending/presentation/notifiers/weekly_trending_state.dart';

import 'package:movie_colony/core/utils/extensions.dart';
import '../../../../providers.dart';

class TvShowOfTheWeek extends ConsumerWidget {
  const TvShowOfTheWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final trending = watch(weeklyTrendingProvider);
    if (trending is WeeklyTrendingLoaded) {
      Trending trend = trending.weeklyTrending[0];
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedImage(
            trend.posterImage.image,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tv show of the week',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text('About ${trend.name}',
                    style: Theme.of(context).textTheme.subtitle2)
              ],
            ),
          ),
          Text(
            trend.overview,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
            child: CustomButton(
              onPressed: () {},
              name: 'Notify Me',
            ),
          )
        ],
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.55,
    );
  }
}


///TODO:NICE PLACEHOLDER AS LOADING SCREEN