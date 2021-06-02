import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/trending.dart';
import '../../domain/repositories/trending_repository.dart';
import '../datasources/trending_local_data_source.dart';
import '../datasources/trending_remote_data_source.dart';

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
  Future<Either<Failure, List<Trending>>> getTrending() async {
    bool isConnected = await networkInfo.isConnected;

    return await getTrendingSwitchCase(isConnected);
  }

  Future<Either<Failure, List<Trending>>> getTrendingSwitchCase(
      bool isConnected) async {
    switch (isConnected) {
      case true:
        return await remoteData();
      case false:
        return await localData();
      default:
        return await remoteData();
    }
  }

  Future<Either<Failure, List<Trending>>> remoteData() async {
    try {
      final remote = await remoteDataSource.getRemoteTrending();
      await localDataSource.cacheLastTrending(remote);
      return Right(remote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Trending>>> localData() async {
    try {
      final localTrending = await localDataSource.getCachedTrending();
      return Right(localTrending);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
