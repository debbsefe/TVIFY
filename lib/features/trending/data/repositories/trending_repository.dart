import 'package:movie_colony/core/core.dart';
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

  Future<TvListModel?> getTrendingWeekly() async {
    return remoteData(TimeWindow.weekly);
  }

  Future<TvListModel?> getTrendingDaily() async {
    return remoteData(TimeWindow.daily);
  }

  Future<TvListModel?> remoteData(
    TimeWindow timeWindow,
  ) async {
    TvListModel? remote;
    if (timeWindow == TimeWindow.daily) {
      remote = await remoteDataSource.getRemoteTrendingDaily();
      await localDataSource.cacheLastTrendingDaily(remote);
    } else {
      remote = await remoteDataSource.getRemoteTrendingWeekly();
      await localDataSource.cacheLastTrendingWeekly(remote);
    }
    return remote;
  }

  Future<TvListModel?> localData(TimeWindow timeWindow) async {
    TvListModel? local;
    if (timeWindow == TimeWindow.daily) {
      local = localDataSource.getCachedTrendingDaily();
    } else {
      local = localDataSource.getCachedTrendingWeekly();
    }

    return local;
  }
}
