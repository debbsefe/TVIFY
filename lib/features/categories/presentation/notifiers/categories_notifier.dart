import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/model/categories_model.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/categories/data/repositories/categories_repository.dart';

final categoriesNotiferProvider =
    StateNotifierProvider<CategoriesNotifier, GenericState<CategoriesModel?>>(
        (ref) {
  return CategoriesNotifier(ref.watch(categoriesRepositoryProvider));
});

class CategoriesNotifier extends GenericStateNotifier<CategoriesModel?> {
  CategoriesNotifier(this.categoriesRepository);

  final CategoriesRepository categoriesRepository;

  void fetchCategory() {
    sendRequest(() async {
      return categoriesRepository.getCategories();
    });
  }
}
