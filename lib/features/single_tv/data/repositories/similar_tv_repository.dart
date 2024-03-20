import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/single_tv/data/datasources/similar_tv_remote_data_source.dart';

final similarTvRepositoryProvider = Provider<SimilarTvRepository>((ref) {
  return SimilarTvRepository(
    remoteDataSource: ref.watch(similarTvRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

class SimilarTvRepository {
  SimilarTvRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final SimilarTvRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  Future<TvList> getSimilarTv(String id) async {
    final remote = await remoteDataSource.getRemoteSimilarTv(id);
    return remote;
  }
}
