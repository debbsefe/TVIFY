import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/features/trending/data/datasources/trending_remote_data_source.dart';

final airingTodayNotifierProvider =
    StateNotifierProvider<AiringTodayNotifier, LoadingState>((ref) {
  return AiringTodayNotifier(ref.watch(trendingRemoteDataSourceProvider))
    ..init();
});

class AiringTodayNotifier extends StateNotifier<LoadingState> {
  AiringTodayNotifier(this.dataSource) : super(const LoadingState.idle());

  final TrendingRemoteDataSource dataSource;
  final logger = Logger('AiringTodayNotifier');

  Future<void> init() async {
    try {
      state = const LoadingState.loading();
      final result = await dataSource.getAiringToday();
      state = LoadingState.success(result);
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
