import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/widgets/cache_image.dart';

// import 'package:movie_colony/core/utils/extensions.dart';
import '../../../../providers.dart';

class TopCast extends ConsumerWidget {
  const TopCast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var url = watch(configurationProvider.notifier).fetchProfileSizeUrl();

    final tvCast = watch(tvCastProvider);

    return tvCast.when(
        initial: () => Container(),
        loading: () => Container(),
        error: (String e) => Text(e.toString()),
        loaded: (castLoaded) {
          var cast = castLoaded ?? [];
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 10),
            itemCount: cast.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              String profileImage = cast[index].profileImage ?? '';
              return Container(
                margin: const EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    CachedImage(
                      url + profileImage,
                      isRound: true,
                      radius: 56,
                    ),
                    Text(
                      cast[index].name ?? '',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
///TODO:NICE PLACEHOLDER AS LOADING SCREEN
