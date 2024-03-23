import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/features/single_tv/data/datasources/tv_detail_remote_data_source.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_detail.dart';

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

  Future<TvDetail> getTvDetail(String id) async {
    return remoteDataSource.getRemoteTvDetail(id);
  }
}
