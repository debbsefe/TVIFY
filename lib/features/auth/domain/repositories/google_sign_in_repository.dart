import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_colony/core/error/failure.dart';

abstract class GoogleSignInRepository {
  Future<Either<Failure, User?>> googleSignInAuth();
}
