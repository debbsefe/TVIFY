import 'package:dartz/dartz.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_local_data_source.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';
import 'package:movie_colony/features/categories/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;
  final CategoriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
    
    if (await networkInfo.isConnected) {
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
}
