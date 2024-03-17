import 'package:dartz/dartz.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/auth/data/datasources/google_sign_in_remote_data_source.dart';
import 'package:movie_colony/features/auth/domain/repositories/google_sign_in_repository.dart';

class GoogleSignInRepositoryImpl implements GoogleSignInRepository {
  GoogleSignInRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final GoogleSignInRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> googleSignInAuth() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.signInWithGoogle();
        return Right(remote);
      } on ServerException {
        return const Left(
          ServerFailure(message: 'Something went wrong, please try again'),
        );
      } on ConflictException {
        return const Left(ConflictFailure(message: 'Account already exists'));
      } on InvalidException {
        return const Left(InvalidFailure(message: 'Invalid details'));
      }
    } else {
      return const Left(CacheFailure(message: 'Poor internet connection'));
    }
  }
}
