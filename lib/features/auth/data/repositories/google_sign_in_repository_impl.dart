import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_colony/features/auth/data/datasources/google_sign_in_remote_data_source.dart';
import 'package:movie_colony/features/auth/domain/repositories/google_sign_in_repository.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

class GoogleSignInRepositoryImpl implements GoogleSignInRepository {
  GoogleSignInRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final GoogleSignInRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, User?>> googleSignInAuth() async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.signInWithGoogle();
        return Right(remote);
      } on ServerException {
        return Left(ServerFailure());
      } on ConflictException {
        return Left(ConflictFailure());
      } on InvalidException {
        return Left(InvalidFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
