import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/model/model.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/core/utils/strings.dart';

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
    final jsonString =
        sharedPreferencesRepository.retrieveString(Strings.cachedCategory);
    if (jsonString != null) {
      return categoriesModelFromJson(jsonString);
    }
    return null;
  }

  Future<void> cacheLastCategory(CategoriesModel? categoriesModel) async {
    if (categoriesModel != null) {
      await sharedPreferencesRepository.saveString(
        expiryDate(Strings.cachedCategory),
        sevenDaysLater,
      );
      await sharedPreferencesRepository.saveString(
        Strings.cachedCategory,
        categoriesModelToJson(categoriesModel),
      );
    }
  }
}
