import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/providers.dart';

class CategoriesWidget extends ConsumerWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    return categories.when(
      initial: Container.new,
      loading: Container.new,
      error: Text.new,
      loaded: (category) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 10),
          itemCount: category!.length,
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
                  category[index].name ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

///TODO:NICE PLACEHOLDER AS LOADING SCREEN
