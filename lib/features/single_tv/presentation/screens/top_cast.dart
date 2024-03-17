import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/core/widgets/cache_image.dart';
// import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/providers.dart';

class TopCast extends ConsumerWidget {
  const TopCast({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = ref.watch(configurationProvider.notifier).fetchProfileSizeUrl();

    final tvCast = ref.watch(tvCastProvider);

    return tvCast.when(
      initial: Container.new,
      loading: Container.new,
      error: Text.new,
      loaded: (castLoaded) {
        final cast = castLoaded ?? [];
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 10),
          itemCount: cast.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final imageUrl = (() {
              switch (cast[index].profileImage) {
                case null:
                  return Strings.noImageAvailable;
                default:
                  return url + cast[index].profileImage!;
              }
            })();
            return Container(
              margin: const EdgeInsets.only(left: 8),
              child: Column(
                children: [
                  CachedImage(
                    imageUrl,
                    isRound: true,
                    radius: 56,
                  ),
                  Text(
                    cast[index].name ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
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
