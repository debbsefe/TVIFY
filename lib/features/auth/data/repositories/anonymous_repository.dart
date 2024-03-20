import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/auth/data/datasources/anonymous_sign_in_remote_data_source.dart';

final anonymousSignInRepositoryrovider =
    Provider<AnonymousSignInRepository>((ref) {
  return AnonymousSignInRepository(
    remoteDataSource: ref.watch(anonymousSignInRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

class AnonymousSignInRepository {
  AnonymousSignInRepository({
    required AnonymousSignInRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  final AnonymousSignInRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  Future<void> anonymousSignInAuth() async {
    await _remoteDataSource.signInAnonymous();
  }
}
