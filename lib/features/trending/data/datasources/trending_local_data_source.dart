import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/models/movie_list/movie_list_model.dart';
import '../../../../core/utils/strings.dart';

abstract class TrendingLocalDataSource {
  ///method to fetch the last data that was fetched,
  ///throws an exception if no cache data is present
  Future<List<MovieListModel>> getCachedTrendingDaily();

  Future<List<MovieListModel>> getCachedTrendingWeekly();

  //method to cache the last data that was fetched
  Future<void> cacheLastTrendingDaily(List<MovieListModel> trendingModel);

  Future<void> cacheLastTrendingWeekly(List<MovieListModel> trendingModel);
}

class TrendingLocalDataSourceImpl implements TrendingLocalDataSource {
  TrendingLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<List<MovieListModel>> getCachedTrendingWeekly() {
    final jsonString = sharedPreferences.getString(Strings.cachedTrending);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return Future.value(parsed
          .map<MovieListModel>((json) => MovieListModel.fromJson(json))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<MovieListModel>> getCachedTrendingDaily() {
    final jsonString = sharedPreferences.getString(Strings.cachedTrending);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return Future.value(parsed
          .map<MovieListModel>((json) => MovieListModel.fromJson(json))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLastTrendingWeekly(List<MovieListModel> trendingModel) {
    return sharedPreferences.setString(
      Strings.cachedTrending,
      json.encode(List<dynamic>.from(trendingModel.map((x) => x.toJson()))),
    );
  }

  @override
  Future<void> cacheLastTrendingDaily(List<MovieListModel> trendingModel) {
    return sharedPreferences.setString(
      Strings.cachedTrending,
      json.encode(List<dynamic>.from(trendingModel.map((x) => x.toJson()))),
    );
  }
}
