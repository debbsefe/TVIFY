import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';
import 'package:movie_colony/features/categories/domain/usecases/get_categories.dart';

///categories
final categoriesNotiferProvider =
    StateNotifierProvider<CategoriesNotifier, GenericState<List<Categories>>>(
        (ref) {
  return CategoriesNotifier(ref.watch(getAllCategoriesProvider));
});

class CategoriesNotifier extends GenericStateNotifier<List<Categories>> {
  CategoriesNotifier(this.allCategories);

  final GetAllCategories allCategories;

  void fetchCategory() {
    sendRequest(() async {
      return allCategories(NoParams());
    });
  }
}
