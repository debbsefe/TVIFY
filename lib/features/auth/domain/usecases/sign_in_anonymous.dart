import 'package:dartz/dartz.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/auth/data/repositories/anonymous_repository_impl.dart';

class SignInAnonymous extends UseCase<void, NoParams> {
  SignInAnonymous(this.repository);

  final AnonymousSignInRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return repository.anonymousSignInAuth();
  }
}
