import 'package:dartz/dartz.dart';
import 'package:movie_colony/core/cache/app_cache.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_local_data_source.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';
import 'package:movie_colony/features/categories/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesRepositoryImpl({
    required this.cache,
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final CategoriesRemoteDataSource remoteDataSource;
  final CategoriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final AppCache cache;

  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
    final bool hasExpired = cache.isExpired(Strings.cachedCategory);

    return await getCategoriesSwitchCase(hasExpired);
  }

  Future<Either<Failure, List<Categories>>> getCategoriesSwitchCase(
    bool hasExpired,
  ) async {
    switch (hasExpired) {
      case true:
        return remoteData();
      case false:
        return localData();
      default:
        return remoteData();
    }
  }

  Future<Either<Failure, List<Categories>>> remoteData() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.getRemoteCategories();
        await localDataSource.cacheLastCategory(remote);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final local = await localDataSource.getCachedCategory();
        return Right(local);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, List<Categories>>> localData() async {
    try {
      final localCategory = await localDataSource.getCachedCategory();
      return Right(localCategory);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
