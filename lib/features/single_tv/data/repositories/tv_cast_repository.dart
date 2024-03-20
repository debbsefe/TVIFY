import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/single_tv/data/datasources/tv_cast_remote_data_source.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_cast.dart';

final tvCastRepositoryProvider = Provider<TvCastRepository>((ref) {
  return TvCastRepository(
    remoteDataSource: ref.watch(tvCastRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

class TvCastRepository {
  TvCastRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final TvCastRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  Future<List<TvCast>> getTvCast(String id) async {
    final remote = await remoteDataSource.getRemoteTvCast(id);
    return remote;
  }
}
