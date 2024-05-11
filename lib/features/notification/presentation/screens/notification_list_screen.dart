import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tvfiy/app_router.dart';
import 'package:tvfiy/core/data/firebase_methods.dart';
import 'package:tvfiy/core/model/notification_list_model.dart';
import 'package:tvfiy/core/utils/size_ext.dart';
import 'package:tvfiy/features/components/tv_large_card.dart';
import 'package:tvfiy/features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'package:tvfiy/features/notification/data/datasources/notification_list_remote_data_source.dart';

final notificationListLengthProvider = StreamProvider.autoDispose<int>(
  (ref) => ref.watch(firebaseMethodsProvider).getNotificationListLength(),
);

final isInNotificationListProvider =
    StreamProvider.autoDispose.family<bool, String>(
  (ref, String docId) =>
      ref.watch(firebaseMethodsProvider).isInNotificationList(docId),
);

@RoutePage()
class NotificationListScreen extends ConsumerStatefulWidget {
  const NotificationListScreen({super.key});

  @override
  ConsumerState<NotificationListScreen> createState() =>
      _NotificationListScreenState();
}

class _NotificationListScreenState
    extends ConsumerState<NotificationListScreen> {
  final PagingController<int, QueryDocumentSnapshot<NotificationListModel>>
      _pagingController = PagingController(firstPageKey: 1);
  @override
  void initState() {
    _pagingController.addPageRequestListener(_fetchPage);

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final lastDocument = _pagingController.itemList?.last;
      final newItems = await ref
          .watch(notificationListRemoteDataSourceProvider)
          .getPaginatedNotificationList(lastDocument);
      final isLastPage = newItems.size < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.docs);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(
          newItems.docs,
          nextPageKey,
        );
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(notificationListLengthProvider, (previous, next) {
      if (previous != next) {
        _pagingController.refresh();
      }
    });
    final length = ref.watch(notificationListLengthProvider).value;

    final url =
        ref.watch(configurationNotifierProvider.notifier).fetchPosterSizeUrl();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Center(child: Text('Notification List')),
              ),
              const SliverToBoxAdapter(child: Height(8)),
              const SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'TV Shows you added to your notification list',
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: Height(32)),
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
              PagedSliverGrid<int,
                  QueryDocumentSnapshot<NotificationListModel>>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<
                    QueryDocumentSnapshot<NotificationListModel>>(
                  itemBuilder: (context, snapshot, index) {
                    final model = snapshot.data();
                    return InkWell(
                      onTap: () {
                        context.router.push(
                          SingleTvDetailRoute(
                            id: model.id.toString(),
                          ),
                        );
                      },
                      child: TvLargeCard(
                        url: url,
                        posterPath: model.posterImage,
                        tvName: model.name,
                      ),
                    );
                  },
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
