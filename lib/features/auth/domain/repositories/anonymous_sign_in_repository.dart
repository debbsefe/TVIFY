import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_colony/core/error/failure.dart';

abstract class AnonymousSignInRepository {
  Future<Either<Failure, User?>> anonymousSignInAuth();
}
