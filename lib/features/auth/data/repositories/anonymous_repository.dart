import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/features/auth/data/datasources/anonymous_sign_in_remote_data_source.dart';

final anonymousSignInRepositoryrovider =
    Provider<AnonymousSignInRepository>((ref) {
  return AnonymousSignInRepository(
    remoteDataSource: ref.watch(anonymousSignInRemoteDataSourceProvider),
  );
});

class AnonymousSignInRepository {
  AnonymousSignInRepository({
    required AnonymousSignInRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final AnonymousSignInRemoteDataSource _remoteDataSource;

  Future<void> anonymousSignInAuth() async {
    await _remoteDataSource.signInAnonymous();
  }
}
