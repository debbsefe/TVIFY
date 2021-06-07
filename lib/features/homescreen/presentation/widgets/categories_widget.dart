import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';
import 'package:movie_colony/features/categories/presentation/notifiers/categories_state.dart';

// import 'package:movie_colony/core/utils/extensions.dart';
import '../../../../providers.dart';

class CategoriesWidget extends ConsumerWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final categories = watch(categoriesProvider);
    if (categories is CategoriesLoaded) {
      List<Categories> category = categories.categories;
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 10),
          itemCount: category.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              width: 100,
              child: Center(
                child: Text(
                  category[index].name,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            );
          });
    }
    return Container();
  }
}


///TODO:NICE PLACEHOLDER AS LOADING SCREEN