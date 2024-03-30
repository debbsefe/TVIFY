import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_remote_data_source.dart';

final trendingRepositoryProvider = Provider<TrendingRepository>((ref) {
  return TrendingRepository(
    remoteDataSource: ref.watch(trendingRemoteDataSourceProvider),
  );
});

class TrendingRepository {
  TrendingRepository({
    required this.remoteDataSource,
  });
  final TrendingRemoteDataSource remoteDataSource;

  Future<TvListModel?> getTrendingWeekly() async {
    return remoteDataSource.getRemoteTrendingWeekly();
  }

  Future<TvListModel?> getTrendingDaily() async {
    return remoteDataSource.getRemoteTrendingDaily();
  }
}
