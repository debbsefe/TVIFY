import 'package:dartz/dartz.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_local_data_source.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_remote_data_source.dart';

enum TimeWindow { weekly, daily }

class TrendingRepository {
  TrendingRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final TrendingRemoteDataSource remoteDataSource;
  final TrendingLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  Future<Either<Failure, TvList>> getTrendingWeekly() async {
    final bool isConnected = await networkInfo.isConnected;

    return getTrendingSwitchCase(isConnected, TimeWindow.weekly);
  }

  Future<Either<Failure, TvList>> getTrendingDaily() async {
    final bool isConnected = await networkInfo.isConnected;

    return getTrendingSwitchCase(isConnected, TimeWindow.daily);
  }

  Future<Either<Failure, TvList>> getTrendingSwitchCase(
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

  Future<Either<Failure, TvList>> remoteData(
    TimeWindow timeWindow,
  ) async {
    try {
      late TvList remote;
      if (timeWindow == TimeWindow.daily) {
        remote = await remoteDataSource.getRemoteTrendingDaily();
        await localDataSource.cacheLastTrendingDaily(remote);
      } else {
        remote = await remoteDataSource.getRemoteTrendingWeekly();
        await localDataSource.cacheLastTrendingWeekly(remote);
      }
      return Right(remote);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, TvList>> localData(TimeWindow timeWindow) async {
    try {
      late TvList local;
      if (timeWindow == TimeWindow.daily) {
        local = await localDataSource.getCachedTrendingDaily();
      } else {
        local = await localDataSource.getCachedTrendingWeekly();
      }

      return Right(local);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
