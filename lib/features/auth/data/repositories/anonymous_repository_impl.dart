import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_colony/features/auth/data/datasources/anonymous_sign_in_remote_data_source.dart';
import 'package:movie_colony/features/auth/domain/repositories/anonymous_sign_in_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

class AnonymousSignInRepositoryImpl implements AnonymousSignInRepository {
  AnonymousSignInRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final AnonymousSignInRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, User?>> anonymousSignInAuth() async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final remote = await remoteDataSource.signInAnonymous();
      return Right(remote);
    } else {
      return const Left(CacheFailure(message: 'Poor internet connection'));
    }
  }
}
