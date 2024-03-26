import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/features/single_tv/data/datasources/tv_detail_remote_data_source.dart';

final tvDetailRepositoryProvider = Provider<TvDetailRepository>((ref) {
  return TvDetailRepository(
    remoteDataSource: ref.watch(tvDetailRemoteDataSourceProvider),
  );
});

class TvDetailRepository {
  TvDetailRepository({
    required this.remoteDataSource,
  });
  final TvDetailRemoteDataSource remoteDataSource;

  Future<TvDetailModel> getTvDetail(String id) async {
    return remoteDataSource.getRemoteTvDetail(id);
  }
}
