import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/app_router.gr.dart';
import 'package:movie_colony/core/widgets/cache_image.dart';
import 'package:movie_colony/providers.dart';

class SimilarTvShowsWidget extends ConsumerWidget {
  const SimilarTvShowsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarTV = ref.watch(similarTvProvider);
    final url = ref.watch(configurationProvider.notifier).fetchPosterSizeUrl();

    return similarTV.when(
      initial: Container.new,
      loading: Container.new,
      error: Text.new,
      loaded: (similar) {
        final tv = similar ?? [];
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 10),
          itemCount: tv.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final singleTv = tv[index];
            final String posterImage = singleTv.posterImage ?? '';

            return Container(
              margin: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pushRoute(
                        SingleTvDetailRoute(
                          id: singleTv.id.toString(),
                        ),
                      );
                    },
                    child: CachedImage(
                      url + posterImage,
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                  Text(
                    singleTv.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 10),
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
