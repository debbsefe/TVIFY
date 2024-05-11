import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/features/trending/data/datasources/trending_remote_data_source.dart';

final dailyTrendingNotifierProvider =
    StateNotifierProvider<DailyTrendingNotifier, LoadingState>((ref) {
  return DailyTrendingNotifier(ref.watch(trendingRemoteDataSourceProvider))
    ..init();
});

class DailyTrendingNotifier extends StateNotifier<LoadingState> {
  DailyTrendingNotifier(this.dataSource) : super(const LoadingState.idle());

  final TrendingRemoteDataSource dataSource;
  final logger = Logger('DailyTrendingNotifier');

  Future<void> init() async {
    try {
      state = const LoadingState.loading();
      final result = await dataSource.getRemoteTrendingDaily();
      state = LoadingState.success(result);
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
