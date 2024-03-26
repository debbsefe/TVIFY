import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/model/tv_list.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_local_data_source.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_remote_data_source.dart';

enum TimeWindow { weekly, daily }

final trendingRepositoryProvider = Provider<TrendingRepository>((ref) {
  return TrendingRepository(
    remoteDataSource: ref.watch(trendingRemoteDataSourceProvider),
    localDataSource: ref.watch(trendingLocalDataSourceProvider),
  );
});

class TrendingRepository {
  TrendingRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  final TrendingRemoteDataSource remoteDataSource;
  final TrendingLocalDataSource localDataSource;

  Future<TvList?> getTrendingWeekly() async {
    return remoteData(TimeWindow.weekly);
  }

  Future<TvList?> getTrendingDaily() async {
    return remoteData(TimeWindow.daily);
  }

  Future<TvList?> remoteData(
    TimeWindow timeWindow,
  ) async {
    TvList? remote;
    if (timeWindow == TimeWindow.daily) {
      remote = await remoteDataSource.getRemoteTrendingDaily();
      await localDataSource.cacheLastTrendingDaily(remote);
    } else {
      remote = await remoteDataSource.getRemoteTrendingWeekly();
      await localDataSource.cacheLastTrendingWeekly(remote);
    }
    return remote;
  }

  Future<TvList?> localData(TimeWindow timeWindow) async {
    TvList? local;
    if (timeWindow == TimeWindow.daily) {
      local = localDataSource.getCachedTrendingDaily();
    } else {
      local = localDataSource.getCachedTrendingWeekly();
    }

    return local;
  }
}
