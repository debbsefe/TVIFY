import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/features/auth/data/datasources/google_sign_in_remote_data_source.dart';

final googleSignInRepositoryProvider = Provider<GoogleSignInRepository>((ref) {
  return GoogleSignInRepository(
    remoteDataSource: ref.watch(googleSignInRemoteDataSourceProvider),
  );
});

class GoogleSignInRepository {
  GoogleSignInRepository({
    required this.remoteDataSource,
  });
  final GoogleSignInRemoteDataSource remoteDataSource;

  Future<void> googleSignInAuth() async {
    await remoteDataSource.signInWithGoogle();
  }
}
