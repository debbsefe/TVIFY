import 'dart:convert';

import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/categories/data/models/categories_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CategoriesLocalDataSource {
  ///method to fetch the last category that was fetched,
  ///throws an exception if no cache data is present
  Future<List<CategoriesModel>> getCachedCategory();

  //method to cache the last category that was fetched
  Future<void> cacheLastCategory(List<CategoriesModel> categoriesModel);
}

class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  CategoriesLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<List<CategoriesModel>> getCachedCategory() {
    final jsonString = sharedPreferences.getString(Strings.cachedCategory);
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

  @override
  Future<void> cacheLastCategory(List<CategoriesModel> categoriesModel) {
    sharedPreferences.setString(
      expiryDate(Strings.cachedCategory),
      sevenDaysLater,
    );
    return sharedPreferences.setString(
      Strings.cachedCategory,
      json.encode(List<dynamic>.from(categoriesModel.map((x) => x.toJson()))),
    );
  }
}
