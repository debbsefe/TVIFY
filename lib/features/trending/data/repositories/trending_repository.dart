import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
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

  Future<TvList> getTrendingWeekly() async {
    return remoteData(TimeWindow.weekly);
  }

  Future<TvList> getTrendingDaily() async {
    return remoteData(TimeWindow.daily);
  }

  Future<TvList> remoteData(
    TimeWindow timeWindow,
  ) async {
    late TvList remote;
    if (timeWindow == TimeWindow.daily) {
      remote = await remoteDataSource.getRemoteTrendingDaily();
      await localDataSource.cacheLastTrendingDaily(remote);
    } else {
      remote = await remoteDataSource.getRemoteTrendingWeekly();
      await localDataSource.cacheLastTrendingWeekly(remote);
    }
    return remote;
  }

  Future<TvList> localData(TimeWindow timeWindow) async {
    late TvList local;
    if (timeWindow == TimeWindow.daily) {
      local = await localDataSource.getCachedTrendingDaily();
    } else {
      local = await localDataSource.getCachedTrendingWeekly();
    }

    return local;
  }
}
