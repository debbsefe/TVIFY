import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/model/tv_list.dart';
import 'package:movie_colony/features/single_tv/data/datasources/similar_tv_remote_data_source.dart';

final similarTvRepositoryProvider = Provider<SimilarTvRepository>((ref) {
  return SimilarTvRepository(
    remoteDataSource: ref.watch(similarTvRemoteDataSourceProvider),
  );
});

class SimilarTvRepository {
  SimilarTvRepository({
    required this.remoteDataSource,
  });
  final SimilarTvRemoteDataSource remoteDataSource;

  Future<TvList> getSimilarTv(String id) async {
    final remote = await remoteDataSource.getRemoteSimilarTv(id);
    return remote;
  }
}
