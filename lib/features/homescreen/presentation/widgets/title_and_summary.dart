import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_colony/app_router.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/utils/date_parser.dart';
import 'package:movie_colony/core/widgets/cache_image.dart';
import 'package:movie_colony/features/configuration/presentation/notifiers/configuration_notifier.dart';

class TitleAndSummary extends ConsumerWidget {
  const TitleAndSummary({required this.state, super.key});
  final LoadingState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url =
        ref.watch(configurationNotifierProvider.notifier).fetchPosterSizeUrl();

    return state.when(
      idle: Container.new,
      loading: Container.new,
      error: (message) {
        return Center(
          child: Text(
            message.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        );
      },
      success: (success) {
        final model = success! as TvListModel;
        final trends = model.results ?? [];

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: trends.map((singleTrend) {
              final String posterImage = singleTrend.posterPath ?? '';
              return Container(
                margin: const EdgeInsets.only(right: 10),
                width: 180,
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
                        child: SizedBox(
                          width: 180,
                          height: 200,
                          child: CachedImage(
                            url + posterImage,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      singleTrend.name ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      yearFromDateString(singleTrend.firstAirDate ?? ''),
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
                          singleTrend.voteAverage?.toStringAsFixed(1) ?? '',
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
            }).toList(),
          ),
        );
      },
    );
  }
}

///TODO:NICE PLACEHOLDER AS LOADING SCREEN
