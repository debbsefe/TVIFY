import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tvfiy/app_router.dart';
import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/core/utils/size_ext.dart';
import 'package:tvfiy/features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'package:tvfiy/features/explore/data/datasources/explore_remote_data_source.dart';
import 'package:tvfiy/features/explore/presentation/widgets/genre_widget.dart';
import 'package:tvfiy/features/homescreen/presentation/screens/homescreen.dart';
import 'package:tvfiy/features/homescreen/presentation/widgets/title_and_summary.dart';
import 'package:tvfiy/features/trending/data/datasources/trending_remote_data_source.dart';
import 'package:tvfiy/features/trending/presentation/notifiers/airing_today_notifier.dart';
import 'package:tvfiy/features/trending/presentation/notifiers/daily_trending_notifier.dart';

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

  final TextEditingController _searchController = TextEditingController();

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
    _searchController.dispose();
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
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SearchBar(
                  leading: const Icon(Icons.search_outlined),
                  hintText: 'Search by tv title',
                  onSubmitted: (value) {
                    _pagingController.itemList = [];
                    _fetchPage(value, 1);
                    query = value;
                    setState(() {});
                  },
                  controller: _searchController,
                  trailing: [
                    CloseButton(
                      onPressed: () {
                        _pagingController.itemList = [];
                        _searchController.clear();
                        query = null;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: Height(24)),
              if (query != null)
                PagedSliverGrid<int, Result>(
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                  ),
                )
              else ...[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const GenreWidget(),
                      const SizedBox(height: 48),
                      HomeSection(
                        title: "Explore what's trending",
                        subtitle: 'Popular tv shows around the world',
                        onSeeAllTap: () {
                          context.pushRoute(
                            ExploreResultRoute(
                              title: 'Trending',
                              fetchItems: (page) {
                                final datasource =
                                    ref.watch(trendingRemoteDataSourceProvider);

                                return datasource.getRemoteTrendingDaily(
                                  page: page.clamp(1, 500),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      TvCard(
                        state: ref.watch(dailyTrendingNotifierProvider),
                      ),
                      const SizedBox(height: 20),
                      HomeSection(
                        title: 'Airing today',
                        subtitle: 'Find out what is airing today',
                        onSeeAllTap: () {
                          context.pushRoute(
                            ExploreResultRoute(
                              title: 'Airing Today',
                              fetchItems: (page) {
                                final datasource =
                                    ref.watch(trendingRemoteDataSourceProvider);

                                return datasource.getAiringToday(
                                  page: page.clamp(1, 500),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      TvCard(
                        state: ref.watch(airingTodayNotifierProvider),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
