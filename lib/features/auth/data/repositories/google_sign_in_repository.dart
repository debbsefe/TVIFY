import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/auth/data/datasources/google_sign_in_remote_data_source.dart';

final googleSignInRepositoryProvider = Provider<GoogleSignInRepository>((ref) {
  return GoogleSignInRepository(
    remoteDataSource: ref.watch(googleSignInRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

class GoogleSignInRepository {
  GoogleSignInRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final GoogleSignInRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  Future<void> googleSignInAuth() async {
    await remoteDataSource.signInWithGoogle();
  }
}
