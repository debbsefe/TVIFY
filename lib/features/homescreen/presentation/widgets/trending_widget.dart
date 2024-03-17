import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/app_router.gr.dart';
import 'package:movie_colony/core/theme/theme.dart';
import 'package:movie_colony/core/utils/date_parser.dart';
import 'package:movie_colony/core/widgets/cache_image.dart';
import 'package:movie_colony/providers.dart';

class TrendingWidget extends ConsumerWidget {
  const TrendingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trending = ref.watch(dailyTrendingProvider);
    final url = ref.watch(configurationProvider.notifier).fetchPosterSizeUrl();

    return trending.when(
      initial: Container.new,
      loading: Container.new,
      error: Text.new,
      loaded: (trends) {
        final trend = trends ?? [];
        // ignore: cascade_invocations
        trend.shuffle();
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 10),
          itemCount: trend.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final singleTrend = trend[index];
            final String posterImage = singleTrend.posterImage ?? '';
            return Container(
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pushRoute(
                        SingleTvDetailRoute(
                          id: singleTrend.id.toString(),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'imageHero-${url + posterImage}',
                      child: CachedImage(
                        url + posterImage,
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                  ),
                  Text(
                    singleTrend.name ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    yearFromDateString(singleTrend.date),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
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
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

///TODO:NICE PLACEHOLDER AS LOADING SCREEN
