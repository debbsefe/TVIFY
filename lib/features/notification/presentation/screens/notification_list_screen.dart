import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/model/notification_list_model.dart';
import 'package:movie_colony/core/utils/size_ext.dart';
import 'package:movie_colony/features/components/tv_large_card.dart';
import 'package:movie_colony/features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'package:movie_colony/features/notification/data/datasources/notification_list_remote_data_source.dart';

final notificationListLengthProvider = StreamProvider.autoDispose<int>(
  (ref) => ref
      .watch(notificationListRemoteDataSourceProvider)
      .fetchNotificationList()
      .asyncMap((event) => event.size),
);

final notificationListProvider =
    StreamProvider.autoDispose<QuerySnapshot<NotificationListModel>>(
  (ref) => ref
      .watch(notificationListRemoteDataSourceProvider)
      .fetchNotificationList(),
);

@RoutePage()
class NotificationListScreen extends ConsumerWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = ref
        .watch(notificationListRemoteDataSourceProvider)
        .fetchNotificationList();

    final length = ref.watch(notificationListLengthProvider).value;

    final url =
        ref.watch(configurationNotifierProvider.notifier).fetchPosterSizeUrl();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: Text('Notification List')),
              const SliverToBoxAdapter(child: Height(8)),
              const SliverToBoxAdapter(
                child: Text(
                  'TV Shows you added to your notification list',
                ),
              ),
              const SliverToBoxAdapter(child: Height(48)),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$length tv shows in your list'),
                          const Text('Filtering by romantic TV shows'),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/filter.png',
                        ),
                        const Width(16),
                        Image.asset(
                          'assets/icons/squares.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: Height(24)),
              StreamBuilder<QuerySnapshot<NotificationListModel>>(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return SliverGrid.builder(
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (context, index) {
                      final model = snapshot.data?.docs[index].data();
                      return TvLargeCard(
                        url: url,
                        posterPath: model?.posterImage,
                        tvName: model?.name,
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
