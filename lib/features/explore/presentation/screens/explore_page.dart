import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_colony/app_router.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/utils/size_ext.dart';
import 'package:movie_colony/features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'package:movie_colony/features/explore/data/datasources/explore_remote_data_source.dart';
import 'package:movie_colony/features/explore/presentation/widgets/genre_widget.dart';

@RoutePage()
class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  final PagingController<int, Result> _pagingController =
      PagingController(firstPageKey: 1);
  String? query;

  @override
  void initState() {
    _pagingController.addPageRequestListener((page) {
      _fetchPage(query ?? '', page);
    });
    super.initState();
  }

  Future<void> _fetchPage(String query, int pageKey) async {
    try {
      final datasource = ref.watch(exploreRemoteDataSourceProvider);
      final newItems = await datasource.searchTV(
        query,
        pageKey.clamp(1, 500),
      );
      final isLastPage = newItems?.totalPages == newItems?.page ||
          (newItems?.results ?? []).isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems!.results!);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems!.results!, nextPageKey);
      }
      setState(() {});
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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SearchBar(
                leading: const Icon(Icons.search_outlined),
                hintText: 'Search by title, actor, genre',
                onSubmitted: (value) {
                  _fetchPage(value, 1);
                  query = value;
                  setState(() {});
                },
                trailing: [
                  CloseButton(
                    onPressed: () {
                      _pagingController.itemList = [];
                      query = null;
                      setState(() {});
                    },
                  ),
                ],
              ),
              const Height(24),
              if (query != null)
                Expanded(
                  child: PagedGridView<int, Result>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Result>(
                      itemBuilder: (context, tv, index) {
                        return InkWell(
                          onTap: () => context.router.push(
                            SingleTvDetailRoute(
                              id: tv.id.toString(),
                            ),
                          ),
                          child: Column(
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
                          ),
                        );
                      },
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                    ),
                  ),
                )
              else
                const GenreWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
