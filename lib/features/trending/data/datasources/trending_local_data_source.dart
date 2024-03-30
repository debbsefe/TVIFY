import 'dart:convert';

import 'package:movie_colony/core/core.dart';
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

  TvListModel? getCachedTrendingWeekly() {
    final jsonString =
        sharedPreferencesRepository.retrieveString(Strings.cachedTrending);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return TvListModel.fromJson(parsed as Map<String, dynamic>);
    }
    return null;
  }

  TvListModel? getCachedTrendingDaily() {
    final jsonString =
        sharedPreferencesRepository.retrieveString(Strings.cachedTrending);
    if (jsonString != null) {
      final parsed = json.decode(jsonString);
      return TvListModel.fromJson(parsed as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<void> cacheLastTrendingWeekly(TvListModel? trendingModel) {
    return sharedPreferencesRepository.saveString(
      Strings.cachedTrending,
      json.encode(trendingModel?.toJson()),
    );
  }

  Future<void> cacheLastTrendingDaily(TvListModel? trendingModel) {
    return sharedPreferencesRepository.saveString(
      Strings.cachedTrending,
      json.encode(trendingModel?.toJson()),
    );
  }
}
