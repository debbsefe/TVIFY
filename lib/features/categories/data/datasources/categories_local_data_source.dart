import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/features/categories/data/models/categories_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

abstract class CategoriesLocalDataSource {
  ///method to fetch the last category that was fetched, throws an exception if no cache data is present
  Future<List<CategoriesModel>> getCachedCategory();

  //method to cache the last category that was fetched
  Future<void> cacheLastCategory(List<CategoriesModel> categoriesModel);
}

const CACHED_MATCH = 'CACHED_MATCH';

class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  final SharedPreferences sharedPreferences;
  CategoriesLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<CategoriesModel>> getCachedCategory() {
    final jsonString = sharedPreferences.getString(CACHED_MATCH);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return Future.value(parsed['genres']
          .map<CategoriesModel>((json) => CategoriesModel.fromJson(json))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLastCategory(List<CategoriesModel> categoriesModel) {
    return sharedPreferences.setString(
      CACHED_MATCH,
      json.encode(List<dynamic>.from(categoriesModel.map((x) => x.toJson()))),
    );
  }
}
