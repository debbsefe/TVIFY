import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_detail_repository.dart';
import '../datasources/movie_detail_remote_data_source.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  MovieDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final MovieDetailRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(String id) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.getRemoteMovieDetail(id);
        return Right(remote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
