import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/usecases/get_trending_daily.dart';
import 'daily_trending_state.dart';

class DailyTrendingNotifier extends StateNotifier<DailyTrendingState> {
  DailyTrendingNotifier(this.dailyTrending) : super(DailyTrendingInitial());

  final GetDailyTrending dailyTrending;

  void fetchTrending() async {
    state = DailyTrendingLoading();
    final result = await dailyTrending(NoParams());
    result.fold(
      (failure) => state = DailyTrendingError(mapFailureToMessage(failure)),
      (trivia) => state = DailyTrendingLoaded(trivia),
    );
  }
}
