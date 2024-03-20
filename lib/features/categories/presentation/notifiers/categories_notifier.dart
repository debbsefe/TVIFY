import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/categories/data/repositories/categories_repository.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';

///categories
final categoriesNotiferProvider =
    StateNotifierProvider<CategoriesNotifier, GenericState<List<Categories>>>(
        (ref) {
  return CategoriesNotifier(ref.watch(categoriesRepositoryProvider));
});

class CategoriesNotifier extends GenericStateNotifier<List<Categories>> {
  CategoriesNotifier(this.categoriesRepository);

  final CategoriesRepository categoriesRepository;

  void fetchCategory() {
    sendRequest(() async {
      return categoriesRepository.getCategories();
    });
  }
}
