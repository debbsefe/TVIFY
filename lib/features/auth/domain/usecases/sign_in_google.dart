import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_colony/features/auth/domain/repositories/google_sign_in_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class SignInGoogle extends UseCase<User?, NoParams> {
  SignInGoogle(this.repository);

  final GoogleSignInRepository repository;

  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await repository.googleSignInAuth();
  }
}
