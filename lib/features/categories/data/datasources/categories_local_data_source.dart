import '../../../../core/error/exception.dart';
import '../../../../core/utils/strings.dart';
import '../models/categories_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

abstract class CategoriesLocalDataSource {
  ///method to fetch the last category that was fetched, throws an exception if no cache data is present
  Future<List<CategoriesModel>> getCachedCategory();

  //method to cache the last category that was fetched
  Future<void> cacheLastCategory(List<CategoriesModel> categoriesModel);
}

class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  final SharedPreferences sharedPreferences;
  CategoriesLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<CategoriesModel>> getCachedCategory() {
    final jsonString = sharedPreferences.getString(CACHED_CATEGORY);
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
    sharedPreferences.setString(expiryDate(CACHED_CATEGORY), sevenDaysLater);
    return sharedPreferences.setString(
      CACHED_CATEGORY,
      json.encode(List<dynamic>.from(categoriesModel.map((x) => x.toJson()))),
    );
  }
}
