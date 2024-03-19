import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/single_tv/data/datasources/tv_detail_remote_data_source.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_detail.dart';

final tvDetailRepositoryProvider = Provider<TvDetailRepository>((ref) {
  return TvDetailRepository(
    remoteDataSource: ref.watch(tvDetailRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

class TvDetailRepository {
  TvDetailRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final TvDetailRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  Future<Either<Failure, TvDetail>> getTvDetail(String id) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.getRemoteTvDetail(id);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}