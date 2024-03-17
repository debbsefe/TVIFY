import 'dart:convert';

import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrendingLocalDataSource {
  TrendingLocalDataSource(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  Future<TvList> getCachedTrendingWeekly() {
    final jsonString = sharedPreferences.getString(Strings.cachedTrending);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return Future.value(
        TvList.fromJson(parsed as Map<String, dynamic>),
      );
    } else {
      throw CacheException();
    }
  }

  Future<TvList> getCachedTrendingDaily() {
    final jsonString = sharedPreferences.getString(Strings.cachedTrending);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return Future.value(
        TvList.fromJson(parsed as Map<String, dynamic>),
      );
    } else {
      throw CacheException();
    }
  }

  Future<void> cacheLastTrendingWeekly(TvList trendingModel) {
    return sharedPreferences.setString(
      Strings.cachedTrending,
      json.encode(trendingModel.toJson()),
    );
  }

  Future<void> cacheLastTrendingDaily(TvList trendingModel) {
    return sharedPreferences.setString(
      Strings.cachedTrending,
      json.encode(trendingModel.toJson()),
    );
  }
}
