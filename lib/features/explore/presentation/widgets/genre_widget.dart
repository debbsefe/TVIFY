import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_colony/app_router.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/features/explore/notifiers/explore_notifier.dart';
import 'package:movie_colony/features/explore/notifiers/genre_notifier.dart';

class GenreWidget extends ConsumerWidget {
  const GenreWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genres = ref.watch(genreNotiferProvider);
    return genres.when(
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
        final value = success! as GenreModel;
        final genres = value.genres ?? [];
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: genres.map((category) {
              return InkWell(
                onTap: () {
                  ref
                      .read(exploreNotiferProvider.notifier)
                      .discoverTVByGenre(genreId: category.id!);

                  context.pushRoute(
                    ExploreResultRoute(
                      title: category.name ?? '',
                      genreId: category.id!,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  width: 100,
                  child: Center(
                    child: Text(
                      category.name ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
