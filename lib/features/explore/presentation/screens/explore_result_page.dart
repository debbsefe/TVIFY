import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/utils/size_ext.dart';
import 'package:movie_colony/features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'package:movie_colony/features/explore/data/datasources/explore_remote_data_source.dart';

@RoutePage()
class ExploreResultPage extends ConsumerStatefulWidget {
  const ExploreResultPage({
    required this.title,
    required this.genreId,
    super.key,
  });
  final String title;
  final int genreId;

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
      final datasource = ref.watch(exploreRemoteDataSourceProvider);
      final newItems = await datasource.discoverTVByGenre(
        widget.genreId,
        pageKey.clamp(1, 500),
      );
      final isLastPage = newItems?.totalPages == newItems?.page;
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      '$url${tv.posterPath}',
                      fit: BoxFit.cover,
                      width: 160,
                    ),
                  ),
                  const Height(8),
                  Text(
                    tv.name ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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
