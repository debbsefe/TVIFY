import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/categories/domain/usecases/get_categories.dart';

import 'categories_state.dart';

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final GetAllCategories allCategories;

  CategoriesNotifier(this.allCategories) : super(CategoriesInitial());
  void fetchCategory() async {
    state = CategoriesLoading();
    final result = await allCategories(NoParams());
    result.fold(
      (failure) => CategoriesError(mapFailureToMessage(failure)),
      (trivia) {
        state = CategoriesLoaded(trivia);
      },
    );
  }
}
