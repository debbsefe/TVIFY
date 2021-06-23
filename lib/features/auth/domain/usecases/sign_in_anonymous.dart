import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_colony/features/auth/domain/repositories/anonymous_sign_in_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class SignInAnonymous extends UseCase<User?, NoParams> {
  SignInAnonymous(this.repository);

  final AnonymousSignInRepository repository;

  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await repository.anonymousSignInAuth();
  }
}
