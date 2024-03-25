import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/model/categories_model.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_local_data_source.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_remote_data_source.dart';

final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  return CategoriesRepository(
    localDataSource: ref.watch(categoriesLocalDataSourceProvider),
    sharedPreferencesRepository: ref.watch(sharedPreferencesRepositoryProvider),
    remoteDataSource: ref.watch(categoriesRemoteDataSourceProvider),
  );
});

class CategoriesRepository {
  CategoriesRepository({
    required this.sharedPreferencesRepository,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  final CategoriesRemoteDataSource remoteDataSource;
  final CategoriesLocalDataSource localDataSource;
  final SharedPreferencesRepository sharedPreferencesRepository;

  Future<CategoriesModel?> getCategories() async {
    final bool hasExpired =
        sharedPreferencesRepository.isExpired(Strings.cachedCategory);

    return getCategoriesSwitchCase(hasExpired);
  }

  Future<CategoriesModel?> getCategoriesSwitchCase(
    bool hasExpired,
  ) async {
    switch (hasExpired) {
      case true:
        return remoteData();
      case false:
        return localData();
      default:
        return remoteData();
    }
  }

  Future<CategoriesModel?> remoteData() async {
    final remote = await remoteDataSource.getRemoteCategories();
    await localDataSource.cacheLastCategory(remote);
    return remote;
  }

  Future<CategoriesModel?> localData() async {
    final localCategory = localDataSource.getCachedCategory();
    return localCategory;
  }
}
