import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/features/categories/presentation/notifiers/categories_notifier.dart';
import 'package:movie_colony/features/configuration/presentation/notifiers/configuration_notifier.dart';
import 'package:movie_colony/features/homescreen/presentation/widgets/categories_widget.dart';
import 'package:movie_colony/features/homescreen/presentation/widgets/trending_widget.dart';
import 'package:movie_colony/features/homescreen/presentation/widgets/tvshow_week.dart';
import 'package:movie_colony/features/trending/presentation/notifiers/daily_trending_notifier.dart';
import 'package:movie_colony/features/trending/presentation/notifiers/weekly_trending_notifier.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _callProviders();
    });
  }

  void _callProviders() {
    ref.read(weeklyTrendingNotifierProvider.notifier).fetchTrending();
    ref.read(dailyTrendingNotifierProvider.notifier).fetchTrending();
    ref.read(categoriesNotiferProvider.notifier).fetchCategory();
    ref.read(configurationNotifierProvider.notifier).fetchConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TvShowOfTheWeek(),
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 100, child: CategoriesWidget()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Explore what’s trending',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'See all',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Popular tv shows around the world',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 400, child: TrendingWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
