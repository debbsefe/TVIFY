import 'package:tvify/core/core.dart';
import 'package:tvify/features/single_tv/data/datasources/tv_cast_remote_data_source.dart';

final tvCastRepositoryProvider = Provider<TvCastRepository>((ref) {
  return TvCastRepository(
    remoteDataSource: ref.watch(tvCastRemoteDataSourceProvider),
  );
});

class TvCastRepository {
  TvCastRepository({
    required this.remoteDataSource,
  });
  final TvCastRemoteDataSource remoteDataSource;

  Future<TvCastModel> getTvCast(String id) async {
    return remoteDataSource.getRemoteTvCast(id);
  }
}
