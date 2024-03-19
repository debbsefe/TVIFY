import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/categories/data/models/categories_model.dart';

final categoriesLocalDataSourceProvider =
    Provider<CategoriesLocalDataSource>((ref) {
  return CategoriesLocalDataSource(
    ref.watch(sharedPreferencesRepositoryProvider),
  );
});

class CategoriesLocalDataSource {
  CategoriesLocalDataSource(this.sharedPreferencesRepository);

  final SharedPreferencesRepository sharedPreferencesRepository;

  Future<List<CategoriesModel>> getCachedCategory() {
    final jsonString =
        sharedPreferencesRepository.retrieveString(Strings.cachedCategory);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return Future.value(
        (parsed as List<dynamic>)
            .map<CategoriesModel>(
              (item) => CategoriesModel.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
      );
    } else {
      throw CacheException();
    }
  }

  Future<void> cacheLastCategory(List<CategoriesModel> categoriesModel) {
    sharedPreferencesRepository.saveString(
      expiryDate(Strings.cachedCategory),
      sevenDaysLater,
    );
    return sharedPreferencesRepository.saveString(
      Strings.cachedCategory,
      json.encode(List<dynamic>.from(categoriesModel.map((x) => x.toJson()))),
    );
  }
}
