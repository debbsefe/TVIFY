import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tvfiy/app_router.dart';
import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/features/components/tv_large_card.dart';
import 'package:tvfiy/features/configuration/presentation/notifiers/configuration_notifier.dart';

@RoutePage()
class ExploreResultPage extends ConsumerStatefulWidget {
  const ExploreResultPage({
    required this.title,
    required this.fetchItems,
    super.key,
  });
  final String title;
  final Future<TvListModel?> Function(int page) fetchItems;

  @override
  ConsumerState<ExploreResultPage> createState() => _ExploreResultPageState();
}

class _ExploreResultPageState extends ConsumerState<ExploreResultPage> {
  final PagingController<int, Result> _pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await widget.fetchItems(pageKey);
      final isLastPage = newItems?.totalPages == newItems?.page ||
          (newItems?.results ?? []).isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems!.results!);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems!.results!, nextPageKey);
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
    final url =
        ref.watch(configurationNotifierProvider.notifier).fetchPosterSizeUrl();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: PagedGridView<int, Result>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Result>(
            itemBuilder: (context, tv, index) {
              return InkWell(
                onTap: () {
                  context.router.push(
                    SingleTvDetailRoute(
                      id: tv.id.toString(),
                    ),
                  );
                },
                child: TvLargeCard(
                  url: url,
                  tvName: tv.name,
                  posterPath: tv.posterPath,
                ),
              );
            },
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
          ),
        ),
      ),
    );
  }
}
