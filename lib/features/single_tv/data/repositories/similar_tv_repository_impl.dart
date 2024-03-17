import 'package:dartz/dartz.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/single_tv/data/datasources/similar_tv_remote_data_source.dart';

class SimilarTvRepository {
  SimilarTvRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final SimilarTvRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  Future<Either<Failure, TvList>> getSimilarTv(String id) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.getRemoteSimilarTv(id);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
