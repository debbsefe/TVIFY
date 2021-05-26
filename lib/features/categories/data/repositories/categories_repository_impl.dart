import 'package:dartz/dartz.dart';
import '../../../../core/cache/app_cache.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/strings.dart';
import '../datasources/categories_local_data_source.dart';
import '../datasources/categories_remote_data_source.dart';
import '../../domain/entities/categories.dart';
import '../../domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;
  final CategoriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final AppCache cache;
  CategoriesRepositoryImpl({
    required this.cache,
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
    bool hasExpired = cache.isExpired(CACHED_CATEGORY);

    return await getCategoriesSwitchCase(hasExpired);
  }

  Future<Either<Failure, List<Categories>>> getCategoriesSwitchCase(
      bool hasExpired) async {
    switch (hasExpired) {
      case true:
        return await remoteData();
      case false:
        return await localData();
      default:
        return await remoteData();
    }
  }

  Future<Either<Failure, List<Categories>>> remoteData() async {
    bool isConnected = await networkInfo.isConnected;
    print('connected $isConnected');
    if (isConnected) {
      try {
        final remoteCategory = await remoteDataSource.getRemoteCategories();
        localDataSource.cacheLastCategory(remoteCategory);
        return Right(remoteCategory);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCategory = await localDataSource.getCachedCategory();
        return Right(localCategory);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, List<Categories>>> localData() async {
    try {
      final localCategory = await localDataSource.getCachedCategory();
      return Right(localCategory);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
