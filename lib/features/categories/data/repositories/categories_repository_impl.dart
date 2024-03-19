import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_local_data_source.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';

final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  return CategoriesRepository(
    localDataSource: ref.watch(categoriesLocalDataSourceProvider),
    sharedPreferencesRepository: ref.watch(sharedPreferencesRepositoryProvider),
    remoteDataSource: ref.watch(categoriesRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

class CategoriesRepository {
  CategoriesRepository({
    required this.sharedPreferencesRepository,
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final CategoriesRemoteDataSource remoteDataSource;
  final CategoriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final SharedPreferencesRepository sharedPreferencesRepository;

  Future<Either<Failure, List<Categories>>> getCategories() async {
    final bool hasExpired =
        sharedPreferencesRepository.isExpired(Strings.cachedCategory);

    return getCategoriesSwitchCase(hasExpired);
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
