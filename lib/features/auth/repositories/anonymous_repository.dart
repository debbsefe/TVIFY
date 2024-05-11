import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tvify/core/data/firebase_methods.dart';

final anonymousSignInRepositoryrovider =
    Provider<AnonymousSignInRepository>((ref) {
  return AnonymousSignInRepository(
    remoteDataSource: ref.watch(firebaseMethodsProvider),
  );
});

class AnonymousSignInRepository {
  AnonymousSignInRepository({
    required FirebaseMethods remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final FirebaseMethods _remoteDataSource;

  Future<void> anonymousSignInAuth() async {
    await _remoteDataSource.signInAnonymous();
  }
}
