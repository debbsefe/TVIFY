import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tvfiy/features/homescreen/presentation/widgets/title_and_summary.dart';
import 'package:tvfiy/features/homescreen/presentation/widgets/tvshow_week.dart';
import 'package:tvfiy/features/trending/presentation/notifiers/airing_today_notifier.dart';
import 'package:tvfiy/features/trending/presentation/notifiers/daily_trending_notifier.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TvShowOfTheWeek(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    HomeSection(
                      title: "Explore what's trending",
                      subtitle: 'Popular tv shows around the world',
                      onSeeAllTap: () {},
                    ),
                    TvCard(
                      state: ref.watch(dailyTrendingNotifierProvider),
                    ),
                    HomeSection(
                      title: 'Airing today',
                      subtitle: 'Find out what is airing today',
                      onSeeAllTap: () {},
                    ),
                    TvCard(
                      state: ref.watch(airingTodayNotifierProvider),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeSection extends StatelessWidget {
  const HomeSection({
    required this.onSeeAllTap,
    required this.title,
    required this.subtitle,
    super.key,
  });
  final VoidCallback onSeeAllTap;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            InkWell(
              onTap: onSeeAllTap,
              child: Text(
                'See all',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
