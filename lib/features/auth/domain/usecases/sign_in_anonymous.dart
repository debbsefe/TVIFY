import 'package:dartz/dartz.dart';

import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/auth/domain/repositories/anonymous_sign_in_repository.dart';

class SignInAnonymous extends UseCase<void, NoParams> {
  SignInAnonymous(this.repository);

  final AnonymousSignInRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.anonymousSignInAuth();
  }
}
