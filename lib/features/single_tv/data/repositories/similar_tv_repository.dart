import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/features/single_tv/data/datasources/similar_tv_remote_data_source.dart';

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

  Future<TvListModel> getSimilarTv(String id) async {
    final remote = await remoteDataSource.getRemoteSimilarTv(id);
    return remote;
  }
}
