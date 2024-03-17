import 'package:dartz/dartz.dart';
import 'package:movie_colony/core/error/failure.dart';

abstract class AnonymousSignInRepository {
  Future<Either<Failure, void>> anonymousSignInAuth();
}
