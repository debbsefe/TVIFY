import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/trending/domain/usecases/get_trending_weekly.dart';

///trending
final weeklyTrendingNotifierProvider =
    StateNotifierProvider<WeeklyTrendingNotifier, GenericState<TvList>>((ref) {
  return WeeklyTrendingNotifier(ref.watch(getWeeklyTrendingProvider));
});

class WeeklyTrendingNotifier extends GenericStateNotifier<TvList> {
  WeeklyTrendingNotifier(this.weeklyTrending);

  final GetWeeklyTrending weeklyTrending;

  void fetchTrending() {
    sendRequest(() async {
      return weeklyTrending(NoParams());
    });
  }
}
