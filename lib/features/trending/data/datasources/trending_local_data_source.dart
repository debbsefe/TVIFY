import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/model/tv_list.dart';
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

  TvList? getCachedTrendingWeekly() {
    final jsonString =
        sharedPreferencesRepository.retrieveString(Strings.cachedTrending);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return TvList.fromJson(parsed as Map<String, dynamic>);
    }
    return null;
  }

  TvList? getCachedTrendingDaily() {
    final jsonString =
        sharedPreferencesRepository.retrieveString(Strings.cachedTrending);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return TvList.fromJson(parsed as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<void> cacheLastTrendingWeekly(TvList? trendingModel) {
    return sharedPreferencesRepository.saveString(
      Strings.cachedTrending,
      json.encode(trendingModel?.toJson()),
    );
  }

  Future<void> cacheLastTrendingDaily(TvList? trendingModel) {
    return sharedPreferencesRepository.saveString(
      Strings.cachedTrending,
      json.encode(trendingModel?.toJson()),
    );
  }
}
