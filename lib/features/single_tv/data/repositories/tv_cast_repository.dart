import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/single_tv/data/datasources/tv_cast_remote_data_source.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_cast.dart';

final tvCastRepositoryProvider = Provider<TvCastRepository>((ref) {
  return TvCastRepository(
    remoteDataSource: ref.watch(tvCastRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

class TvCastRepository {
  TvCastRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final TvCastRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  Future<Either<Failure, List<TvCast>>> getTvCast(String id) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.getRemoteTvCast(id);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
