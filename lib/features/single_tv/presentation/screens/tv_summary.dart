import 'package:flutter/material.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/utils/size_ext.dart';
import 'package:movie_colony/core/widgets/buttons.dart';
import 'package:movie_colony/features/notification/presentation/notifiers/add_notif_list_notifier.dart';
import 'package:movie_colony/features/single_tv/presentation/notifiers/tv_detail/tv_detail_notifier.dart';

class TvSummary extends ConsumerWidget {
  const TvSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tvDetail = ref.watch(tvDetailNotifierProvider);

    return tvDetail.when(
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
        final detail = success! as TvDetailModel;
        final String overview = detail.overview ?? '';
        final categories = detail.genres ?? [];
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Plot Summary',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Height(10),
              Text(
                overview,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 12),
              ),
              const Height(15),
              Text(
                'Genres',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Height(15),
              Wrap(
                spacing: 10,
                runSpacing: 15,
                alignment: WrapAlignment.spaceBetween,
                children: categories.map((e) {
                  return GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: CustomTheme.primaryTint5,
                        border: Border.all(
                          color: CustomTheme.primaryTint2,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3)),
                      ),
                      child: Text(
                        e.name ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: CustomButton(
                  onPressed: () {
                    ref
                        .read(addNotificationListNotifierProvider.notifier)
                        .addNotification(
                          NotificationListModel(
                            id: detail.id,
                            name: detail.name,
                            rating: detail.voteAverage,
                            date: detail.firstAirDate,
                            posterImage: detail.posterPath,
                          ),
                        );
                  },
                  name: 'Notify Me',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
