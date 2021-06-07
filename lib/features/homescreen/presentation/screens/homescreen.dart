import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/features/homescreen/presentation/widgets/categories_widget.dart';

import 'package:movie_colony/features/homescreen/presentation/widgets/tvshow_week.dart';

import '../../../../providers.dart';

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
    context.read(categoriesProvider.notifier).fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TvShowOfTheWeek(),
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 100, child: CategoriesWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
