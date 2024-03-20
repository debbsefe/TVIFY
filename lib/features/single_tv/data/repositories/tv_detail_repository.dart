import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/single_tv/data/datasources/tv_detail_remote_data_source.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_detail.dart';

final tvDetailRepositoryProvider = Provider<TvDetailRepository>((ref) {
  return TvDetailRepository(
    remoteDataSource: ref.watch(tvDetailRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

class TvDetailRepository {
  TvDetailRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final TvDetailRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  Future<TvDetail> getTvDetail(String id) async {
    return remoteDataSource.getRemoteTvDetail(id);
  }
}
