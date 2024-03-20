import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/trending/data/repositories/trending_repository.dart';

///trending
final weeklyTrendingNotifierProvider =
    StateNotifierProvider<WeeklyTrendingNotifier, GenericState<TvList>>((ref) {
  return WeeklyTrendingNotifier(ref.watch(trendingRepositoryProvider));
});

class WeeklyTrendingNotifier extends GenericStateNotifier<TvList> {
  WeeklyTrendingNotifier(this.trendingRepository);

  final TrendingRepository trendingRepository;

  void fetchTrending() {
    sendRequest(() async {
      return trendingRepository.getTrendingWeekly();
    });
  }
}
