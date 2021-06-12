import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/cache_image.dart';
import '../../../../providers.dart';
import '../../../trending/presentation/notifiers/daily_trending_state.dart';

class TrendingWidget extends ConsumerWidget {
  const TrendingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final trending = watch(dailyTrendingProvider);
    if (trending is DailyTrendingLoaded) {
      List<TvList> trend = trending.dailyTrending;
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 10),
          itemCount: trend.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            var singleTrend = trend[index];
            return Container(
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedImage(
                    trend[index].posterImage.image,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Text(
                    singleTrend.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    '2002',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: CustomTheme.greyColor3),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 13,
                        color: CustomTheme.yellowStar,
                      ),
                      Text(
                        singleTrend.rating.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    }
    return Container();
  }
}

///TODO:NICE PLACEHOLDER AS LOADING SCREEN
