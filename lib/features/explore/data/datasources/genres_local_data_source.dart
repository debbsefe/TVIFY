import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';

final genresLocalDataSourceProvider = Provider<GenresLocalDataSource>((ref) {
  return GenresLocalDataSource(
    ref.watch(sharedPreferencesRepositoryProvider),
  );
});

class GenresLocalDataSource {
  GenresLocalDataSource(this.sharedPreferencesRepository);

  final SharedPreferencesRepository sharedPreferencesRepository;

  GenreModel? getCachedCategory() {
    final jsonString = sharedPreferencesRepository.getCategoryCache();
    if (jsonString != null) {
      return genreModelFromJson(jsonString);
    }
    return null;
  }

  Future<void> cacheLastCategory(GenreModel? genresModel) async {
    if (genresModel != null) {
      await sharedPreferencesRepository.setCategoryCache(genresModel);
    }
  }
}
