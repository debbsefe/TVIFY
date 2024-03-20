import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_local_data_source.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_remote_data_source.dart';

enum TimeWindow { weekly, daily }

final trendingRepositoryProvider = Provider<TrendingRepository>((ref) {
  return TrendingRepository(
    remoteDataSource: ref.watch(trendingRemoteDataSourceProvider),
    localDataSource: ref.watch(trendingLocalDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

class TrendingRepository {
  TrendingRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final TrendingRemoteDataSource remoteDataSource;
  final TrendingLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  Future<TvList> getTrendingWeekly() async {
    final bool isConnected = networkInfo.isConnected;

    return getTrendingSwitchCase(isConnected, TimeWindow.weekly);
  }

  Future<TvList> getTrendingDaily() async {
    final bool isConnected = networkInfo.isConnected;

    return getTrendingSwitchCase(isConnected, TimeWindow.daily);
  }

  Future<TvList> getTrendingSwitchCase(
    bool isConnected,
    TimeWindow timeWindow,
  ) async {
    switch (isConnected) {
      case true:
        return remoteData(timeWindow);
      case false:
        return localData(timeWindow);
      default:
        return remoteData(timeWindow);
    }
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
