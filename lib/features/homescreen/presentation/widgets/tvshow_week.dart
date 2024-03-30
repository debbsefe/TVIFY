import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/widgets/buttons.dart';
import 'package:movie_colony/core/widgets/cache_image.dart';
import 'package:movie_colony/core/widgets/dialogs.dart';
import 'package:movie_colony/features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'package:movie_colony/features/notification/presentation/notifiers/add_notif_list_notifier.dart';
import 'package:movie_colony/features/trending/presentation/notifiers/weekly_trending_notifier.dart';

class TvShowOfTheWeek extends ConsumerWidget {
  const TvShowOfTheWeek({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trending = ref.watch(weeklyTrendingNotifierProvider);
    final url =
        ref.watch(configurationNotifierProvider.notifier).fetchPosterSizeUrl();

    ref.listen(addNotificationListNotifierProvider, (previous, next) {
      next.mapOrNull(
        error: (error) {
          messageDialog(
            context: context,
            onPressed: () {
              context.router.root.maybePop();
            },
            content: error.error.toString(),
          );
        },
        success: (success) {
          messageDialog(
            context: context,
            onPressed: () {
              context.router.root.maybePop();
            },
            content: 'Notification added',
          );
        },
      );
    });
    return trending.when(
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
        final trends = success! as TvListModel;
        final trend = trends.results?.first;
        final String posterImage = trend?.posterPath ?? '';

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
                    'About ${trend?.name}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Text(
              trend?.overview ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
              child: CustomButton(
                onPressed: () {
                  ref
                      .read(addNotificationListNotifierProvider.notifier)
                      .addNotification(
                        NotificationListModel(
                          id: trend?.id,
                          name: trend?.name,
                          rating: trend?.voteAverage,
                          date: trend?.firstAirDate,
                          posterImage: trend?.posterPath,
                        ),
                      );
                },
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
