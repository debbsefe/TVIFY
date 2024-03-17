import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/widgets/buttons.dart';
import 'package:movie_colony/core/widgets/cache_image.dart';
import 'package:movie_colony/providers.dart';

class TvShowOfTheWeek extends ConsumerWidget {
  const TvShowOfTheWeek({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trending = ref.watch(weeklyTrendingProvider);
    final url = ref.watch(configurationProvider.notifier).fetchPosterSizeUrl();

    return trending.when(
      initial: Container.new,
      loading: Container.new,
      error: Text.new,
      loaded: (trends) {
        final trend = trends!.first;
        final String posterImage = trend.posterImage ?? '';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImage(
              url + posterImage,
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tv show of the week',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'About ${trend.name}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Text(
              trend.overview ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
              child: CustomButton(
                onPressed: () {},
                name: 'Notify Me',
              ),
            ),
          ],
        );
      },
    );
  }
}

///TODO:NICE PLACEHOLDER AS LOADING SCREEN
