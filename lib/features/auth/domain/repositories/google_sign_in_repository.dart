import 'package:dartz/dartz.dart';
import 'package:movie_colony/core/error/failure.dart';

abstract class GoogleSignInRepository {
  Future<Either<Failure, void>> googleSignInAuth();
}
