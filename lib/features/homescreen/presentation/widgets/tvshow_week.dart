import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/tv_list/tv_list.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/cache_image.dart';
import '../../../../providers.dart';
import '../../../trending/presentation/notifiers/weekly_trending_state.dart';

class TvShowOfTheWeek extends ConsumerWidget {
  const TvShowOfTheWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final trending = watch(weeklyTrendingProvider);
    var url = watch(configurationProvider.notifier).fetchPosterSizeUrl();

    if (trending is WeeklyTrendingLoaded) {
      TvList trend = trending.weeklyTrending[0];
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedImage(
            url + trend.posterImage,
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
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
