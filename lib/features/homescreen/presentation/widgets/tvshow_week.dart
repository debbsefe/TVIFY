import 'package:flutter/material.dart';
import 'package:tvify/core/core.dart';
import 'package:tvify/features/components/buttons.dart';
import 'package:tvify/features/components/cache_image.dart';
import 'package:tvify/features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'package:tvify/features/notification/presentation/notifiers/notification_list_notifier.dart';
import 'package:tvify/features/notification/presentation/screens/notification_list_screen.dart';
import 'package:tvify/features/trending/presentation/notifiers/weekly_trending_notifier.dart';

final _aboutProvider = StateProvider<bool>((ref) {
  return false;
});

class TvShowOfTheWeek extends ConsumerWidget {
  const TvShowOfTheWeek({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trending = ref.watch(weeklyTrendingNotifierProvider);
    final url =
        ref.watch(configurationNotifierProvider.notifier).fetchPosterSizeUrl();

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

        final isInNotificationList = ref
                .watch(isInNotificationListProvider(trend!.id.toString()))
                .value ??
            false;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImage(
              url + posterImage,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TV Show of the Week',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: CustomTheme.nonPhotoBlue),
                  ),
                  Text(
                    'Weekly recommended TV shows for you',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: CustomTheme.nonPhotoBlue),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${trend.name}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  InkWell(
                    onTap: () {
                      final showAbout = ref.watch(_aboutProvider);
                      ref.watch(_aboutProvider.notifier).state = !showAbout;
                    },
                    child: Text(
                      'About ${trend.name}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
            if (ref.watch(_aboutProvider))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  trend.overview ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: CustomButton(
                onPressed: () {
                  isInNotificationList
                      ? ref
                          .read(notificationListNotifierProvider.notifier)
                          .removeNotification(
                            NotificationListModel(
                              id: trend.id,
                              name: trend.name,
                              rating: trend.voteAverage,
                              date: trend.firstAirDate,
                              posterImage: trend.posterPath,
                            ),
                          )
                      : ref
                          .read(notificationListNotifierProvider.notifier)
                          .addNotification(
                            NotificationListModel(
                              id: trend.id,
                              name: trend.name,
                              rating: trend.voteAverage,
                              date: trend.firstAirDate,
                              posterImage: trend.posterPath,
                            ),
                          );
                },
                name: isInNotificationList
                    ? 'Remove from Notification List'
                    : 'Notify Me',
              ),
            ),
          ],
        );
      },
    );
  }
}
