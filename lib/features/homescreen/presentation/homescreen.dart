import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/widgets/buttons.dart';
import 'package:movie_colony/features/trending/domain/entities/trending.dart';
import 'package:movie_colony/features/trending/presentation/notifiers/trending_state.dart';

import 'package:movie_colony/core/utils/extensions.dart';
import '../../../providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    callProviders();
  }

  Future<void> callProviders() async {
    context.read(trendingProvider.notifier).fetchTrending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TvShowOfTheWeek(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TvShowOfTheWeek extends ConsumerWidget {
  const TvShowOfTheWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final trending = watch(trendingProvider);
    if (trending is TrendingLoaded) {
      Trending trend = trending.trending[1];
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.network(
              trend.posterImage.image,
              // width: 100,
              // height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tv show of the week',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text('About ${trend.name}',
                    style: Theme.of(context).textTheme.subtitle2)
              ],
            ),
          ),
          Text(
            trend.overview,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: CustomButton(
              onPressed: () {},
              name: 'Notify Me',
            ),
          )
        ],
      );
    }
    return Container();
  }
}
