import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/core/utils/strings.dart';

final trendingLocalDataSourceProvider =
    Provider<TrendingLocalDataSource>((ref) {
  return TrendingLocalDataSource(
    ref.watch(sharedPreferencesRepositoryProvider),
  );
});

class TrendingLocalDataSource {
  TrendingLocalDataSource(this.sharedPreferencesRepository);

  final SharedPreferencesRepository sharedPreferencesRepository;

  Future<TvList> getCachedTrendingWeekly() {
    final jsonString =
        sharedPreferencesRepository.retrieveString(Strings.cachedTrending);
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
    final jsonString =
        sharedPreferencesRepository.retrieveString(Strings.cachedTrending);
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
    return sharedPreferencesRepository.saveString(
      Strings.cachedTrending,
      json.encode(trendingModel.toJson()),
    );
  }

  Future<void> cacheLastTrendingDaily(TvList trendingModel) {
    return sharedPreferencesRepository.saveString(
      Strings.cachedTrending,
      json.encode(trendingModel.toJson()),
    );
  }
}
