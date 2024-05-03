import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_colony/features/explore/presentation/widgets/genres_widget.dart';

@RoutePage()
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SearchBar(
                leading: Icon(Icons.search_outlined),
                hintText: 'Search by title, actor, genre',
                onChanged: print,
              ),
              GenresWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
