import 'package:flutter/material.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/theme/theme.dart';
import 'package:movie_colony/core/utils/date_parser.dart';
import 'package:movie_colony/core/utils/size_ext.dart';
import 'package:movie_colony/core/widgets/cache_image.dart';
import 'package:movie_colony/features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'package:movie_colony/features/single_tv/presentation/notifiers/tv_detail/tv_detail_notifier.dart';

class HeaderImage extends ConsumerWidget {
  const HeaderImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tvDetail = ref.watch(tvDetailNotifierProvider);
    final url =
        ref.watch(configurationNotifierProvider.notifier).fetchPosterSizeUrl();

    return tvDetail.when(
      idle: () => Height(MediaQuery.of(context).size.height * 0.55),
      loading: () => Height(MediaQuery.of(context).size.height * 0.55),
      error: (message) {
        return Center(
          child: Text(
            message.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        );
      },
      success: (success) {
        final detail = success! as TvDetailModel;
        final String posterImage = detail.posterPath ?? '';
        final String name = detail.name ?? '';

        return Column(
          children: [
            Hero(
              tag: 'imageHero-${url + posterImage}',
              child: CachedImage(
                url + posterImage,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            yearFromDateString(
                              detail.firstAirDate ?? '',
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: CustomTheme.greyColor3),
                          ),
                          const Width(10),
                          Text(
                            fetchSeason(
                              detail.numberOfSeasons,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: CustomTheme.greyColor3),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: CustomTheme.yellowStar,
                          ),
                          const Width(5),
                          Text(
                            detail.voteAverage.toString(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: CustomTheme.primaryTint4,
              thickness: 0.75,
            ),
          ],
        );
      },
    );
  }
}

String fetchSeason(int? value) {
  return value == null
      ? ''
      : value > 1
          ? '$value Seasons'
          : '$value Season';
}
