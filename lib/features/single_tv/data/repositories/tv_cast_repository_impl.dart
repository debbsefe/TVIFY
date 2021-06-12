import 'package:dartz/dartz.dart';
import 'package:movie_colony/features/single_tv/data/datasources/tv_cast_remote_data_source.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_cast.dart';
import 'package:movie_colony/features/single_tv/domain/repositories/tv_cast_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

class TvCastRepositoryImpl implements TvCastRepository {
  TvCastRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final TvCastRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, TvCast>> getTvCast(String id) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.getRemoteTvCast(id);
        return Right(remote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
