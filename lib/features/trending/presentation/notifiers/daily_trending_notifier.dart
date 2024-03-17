import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/trending/domain/usecases/get_trending_daily.dart';

class DailyTrendingNotifier extends GenericStateNotifier<List<TvList>> {
  DailyTrendingNotifier(this.dailyTrending);

  final GetDailyTrending dailyTrending;

  void fetchTrending() {
    sendRequest(() async {
      return await dailyTrending(NoParams());
    });
  }
}
