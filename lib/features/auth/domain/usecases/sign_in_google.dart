import 'package:dartz/dartz.dart';

import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/auth/domain/repositories/google_sign_in_repository.dart';

class SignInGoogle extends UseCase<void, NoParams> {
  SignInGoogle(this.repository);

  final GoogleSignInRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.googleSignInAuth();
  }
}
