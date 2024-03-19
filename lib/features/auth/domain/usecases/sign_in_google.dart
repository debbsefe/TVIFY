import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/auth/data/repositories/google_sign_in_repository.dart';

final signInGoogleProvider = Provider<SignInGoogle>((ref) {
  return SignInGoogle(ref.watch(googleSignInRepositoryProvider));
});

class SignInGoogle extends UseCase<void, NoParams> {
  SignInGoogle(this.repository);

  final GoogleSignInRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return repository.googleSignInAuth();
  }
}
