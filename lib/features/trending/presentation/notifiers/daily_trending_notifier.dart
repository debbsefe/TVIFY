import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/features/trending/data/repositories/trending_repository.dart';

final dailyTrendingNotifierProvider =
    StateNotifierProvider<DailyTrendingNotifier, LoadingState>((ref) {
  return DailyTrendingNotifier(ref.watch(trendingRepositoryProvider));
});

class DailyTrendingNotifier extends StateNotifier<LoadingState> {
  DailyTrendingNotifier(this.trendingRepository)
      : super(const LoadingState.idle());

  final TrendingRepository trendingRepository;
  final logger = Logger('DailyTrendingNotifier');

  Future<void> fetchTrending() async {
    try {
      state = const LoadingState.loading();
      final result = await trendingRepository.getTrendingDaily();
      state = LoadingState.success(result);
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
