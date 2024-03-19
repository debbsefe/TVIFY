import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/trending/domain/usecases/get_trending_daily.dart';

final dailyTrendingNotifierProvider =
    StateNotifierProvider<DailyTrendingNotifier, GenericState<TvList>>((ref) {
  return DailyTrendingNotifier(ref.watch(getDailyTrendingProvider));
});

class DailyTrendingNotifier extends GenericStateNotifier<TvList> {
  DailyTrendingNotifier(this.dailyTrending);

  final GetDailyTrending dailyTrending;

  void fetchTrending() {
    sendRequest(() async {
      return dailyTrending(NoParams());
    });
  }
}
