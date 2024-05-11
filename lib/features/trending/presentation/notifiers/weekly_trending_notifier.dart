import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/features/trending/data/datasources/trending_remote_data_source.dart';

final weeklyTrendingNotifierProvider =
    StateNotifierProvider<WeeklyTrendingNotifier, LoadingState>((ref) {
  return WeeklyTrendingNotifier(ref.watch(trendingRemoteDataSourceProvider))
    ..init();
});

class WeeklyTrendingNotifier extends StateNotifier<LoadingState> {
  WeeklyTrendingNotifier(this.dataSource) : super(const LoadingState.idle());

  final TrendingRemoteDataSource dataSource;
  final logger = Logger('WeeklyTrendingNotifier');

  Future<void> init() async {
    try {
      state = const LoadingState.loading();
      final result = await dataSource.getRemoteTrendingWeekly();
      state = LoadingState.success(result);
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
