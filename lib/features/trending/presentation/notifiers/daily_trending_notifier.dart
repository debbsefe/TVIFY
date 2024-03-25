import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/model/tv_list.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/trending/data/repositories/trending_repository.dart';

final dailyTrendingNotifierProvider =
    StateNotifierProvider<DailyTrendingNotifier, GenericState<TvList?>>((ref) {
  return DailyTrendingNotifier(ref.watch(trendingRepositoryProvider));
});

class DailyTrendingNotifier extends GenericStateNotifier<TvList?> {
  DailyTrendingNotifier(this.trendingRepository);

  final TrendingRepository trendingRepository;

  void fetchTrending() {
    sendRequest(() async {
      return trendingRepository.getTrendingDaily();
    });
  }
}
