import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/utils/strings.dart';
import '../models/trending_model.dart';

abstract class TrendingLocalDataSource {
  ///method to fetch the last data that was fetched,
  ///throws an exception if no cache data is present
  Future<List<TrendingModel>> getCachedTrending();

  //method to cache the last data that was fetched
  Future<void> cacheLastTrending(List<TrendingModel> trendingModel);
}

class TrendingLocalDataSourceImpl implements TrendingLocalDataSource {
  TrendingLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<List<TrendingModel>> getCachedTrending() {
    final jsonString = sharedPreferences.getString(Strings.cachedTrending);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return Future.value(parsed
          .map<TrendingModel>((json) => TrendingModel.fromJson(json))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLastTrending(List<TrendingModel> trendingModel) {
    return sharedPreferences.setString(
      Strings.cachedTrending,
      json.encode(List<dynamic>.from(trendingModel.map((x) => x.toJson()))),
    );
  }
}