import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';

final genreLocalDataSourceProvider = Provider<GenreLocalDataSource>((ref) {
  return GenreLocalDataSource(
    ref.watch(sharedPreferencesRepositoryProvider),
  );
});

class GenreLocalDataSource {
  GenreLocalDataSource(this.sharedPreferencesRepository);

  final SharedPreferencesRepository sharedPreferencesRepository;

  GenreModel? getCachedCategory() {
    final jsonString = sharedPreferencesRepository.getCategoryCache();
    if (jsonString != null) {
      return genreModelFromJson(jsonString);
    }
    return null;
  }

  Future<void> cacheLastCategory(GenreModel? genreModel) async {
    if (genreModel != null) {
      await sharedPreferencesRepository.setCategoryCache(genreModel);
    }
  }
}
