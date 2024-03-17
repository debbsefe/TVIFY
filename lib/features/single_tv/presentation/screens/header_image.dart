import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/theme/theme.dart';
import 'package:movie_colony/core/utils/date_parser.dart';
import 'package:movie_colony/core/utils/size_ext.dart';
import 'package:movie_colony/core/widgets/cache_image.dart';
import 'package:movie_colony/providers.dart';

class HeaderImage extends ConsumerWidget {
  const HeaderImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tvDetail = ref.watch(tvDetailProvider);
    final url = ref.watch(configurationProvider.notifier).fetchPosterSizeUrl();

    return tvDetail.when(
      initial: () => Height(MediaQuery.of(context).size.height * 0.55),
      loading: () => Height(MediaQuery.of(context).size.height * 0.55),
      error: Text.new,
      loaded: (detail) {
        final String posterImage = detail!.posterImage ?? '';
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
                            yearFromDateString(detail.startDate),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: CustomTheme.greyColor3),
                          ),
                          const Width(10),
                          Text(
                            fetchSeason(
                              detail.seasons,
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
                            detail.rating.toString(),
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
