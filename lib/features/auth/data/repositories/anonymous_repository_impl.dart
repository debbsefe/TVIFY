import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/auth/data/datasources/anonymous_sign_in_remote_data_source.dart';

final anonymousSignInRepositoryrovider =
    Provider<AnonymousSignInRepository>((ref) {
  return AnonymousSignInRepository(
    remoteDataSource: ref.watch(anonymousSignInRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

class AnonymousSignInRepository {
  AnonymousSignInRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final AnonymousSignInRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  Future<Either<Failure, void>> anonymousSignInAuth() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final remote = await remoteDataSource.signInAnonymous();
      return Right(remote);
    } else {
      return const Left(CacheFailure(message: 'Poor internet connection'));
    }
  }
}
