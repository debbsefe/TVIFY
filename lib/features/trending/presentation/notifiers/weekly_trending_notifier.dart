import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/features/trending/data/repositories/trending_repository.dart';

final weeklyTrendingNotifierProvider =
    StateNotifierProvider<WeeklyTrendingNotifier, LoadingState>((ref) {
  return WeeklyTrendingNotifier(ref.watch(trendingRepositoryProvider));
});

class WeeklyTrendingNotifier extends StateNotifier<LoadingState> {
  WeeklyTrendingNotifier(this.trendingRepository)
      : super(const LoadingState.idle());

  final TrendingRepository trendingRepository;
  final logger = Logger('DailyTrendingNotifier');

  Future<void> fetchTrending() async {
    try {
      state = const LoadingState.loading();
      final result = await trendingRepository.getTrendingWeekly();
      state = LoadingState.success(result);
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
