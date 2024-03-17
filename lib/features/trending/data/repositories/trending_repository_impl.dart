import 'package:dartz/dartz.dart';

import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/models/tv_list/tv_list_model.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/trending/domain/repositories/trending_repository.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_local_data_source.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_remote_data_source.dart';

enum TimeWindow { weekly, daily }

class TrendingRepositoryImpl implements TrendingRepository {
  TrendingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final TrendingRemoteDataSource remoteDataSource;
  final TrendingLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<TvList>>> getTrendingWeekly() async {
    final bool isConnected = await networkInfo.isConnected;

    return await getTrendingSwitchCase(isConnected, TimeWindow.weekly);
  }

  @override
  Future<Either<Failure, List<TvList>>> getTrendingDaily() async {
    final bool isConnected = await networkInfo.isConnected;

    return await getTrendingSwitchCase(isConnected, TimeWindow.daily);
  }

  Future<Either<Failure, List<TvList>>> getTrendingSwitchCase(
      bool isConnected, TimeWindow timeWindow,) async {
    switch (isConnected) {
      case true:
        return await remoteData(timeWindow);
      case false:
        return await localData(timeWindow);
      default:
        return await remoteData(timeWindow);
    }
  }

  Future<Either<Failure, List<TvList>>> remoteData(
      TimeWindow timeWindow,) async {
    try {
      late List<TvListModel> remote;
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

  Future<Either<Failure, List<TvList>>> localData(TimeWindow timeWindow) async {
    try {
      late List<TvListModel> local;
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
