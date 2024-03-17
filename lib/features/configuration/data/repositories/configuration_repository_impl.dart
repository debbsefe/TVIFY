import 'package:dartz/dartz.dart';

import 'package:movie_colony/core/cache/app_cache.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/configuration/domain/entities/configuration.dart';
import 'package:movie_colony/features/configuration/domain/repositories/configuration_repository.dart';
import 'package:movie_colony/features/configuration/data/datasources/configuration_local_data_source.dart';
import 'package:movie_colony/features/configuration/data/datasources/configuration_remote_data_source.dart';

class ConfigurationRepositoryImpl implements ConfigurationRepository {
  ConfigurationRepositoryImpl({
    required this.cache,
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final ConfigurationRemoteDataSource remoteDataSource;
  final ConfigurationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final AppCache cache;

  @override
  Future<Either<Failure, Configuration>> getConfiguration() async {
    final bool hasExpired = cache.isExpired(Strings.cachedConfiguration);

    return await getConfigurationSwitchCase(hasExpired);
  }

  Future<Either<Failure, Configuration>> getConfigurationSwitchCase(
      bool hasExpired,) async {
    switch (hasExpired) {
      case true:
        return await remoteData();
      case false:
        return await localData();
      default:
        return await remoteData();
    }
  }

  Future<Either<Failure, Configuration>> remoteData() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.getRemoteConfiguration();
        await localDataSource.cacheLastConfiguration(remote);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final local = await localDataSource.getCachedConfiguration();
        return Right(local);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, Configuration>> localData() async {
    try {
      final local = await localDataSource.getCachedConfiguration();
      return Right(local);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
