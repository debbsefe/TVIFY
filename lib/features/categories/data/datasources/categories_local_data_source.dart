import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/model/model.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';

final categoriesLocalDataSourceProvider =
    Provider<CategoriesLocalDataSource>((ref) {
  return CategoriesLocalDataSource(
    ref.watch(sharedPreferencesRepositoryProvider),
  );
});

class CategoriesLocalDataSource {
  CategoriesLocalDataSource(this.sharedPreferencesRepository);

  final SharedPreferencesRepository sharedPreferencesRepository;

  CategoriesModel? getCachedCategory() {
    final jsonString = sharedPreferencesRepository.getCategoryCache();
    if (jsonString != null) {
      return categoriesModelFromJson(jsonString);
    }
    return null;
  }

  Future<void> cacheLastCategory(CategoriesModel? categoriesModel) async {
    if (categoriesModel != null) {
      await sharedPreferencesRepository.setCategoryCache(categoriesModel);
    }
  }
}
