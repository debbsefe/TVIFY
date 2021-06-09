import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/usecases/get_trending_weekly.dart';

import 'weekly_trending_state.dart';

class WeeklyTrendingNotifier extends StateNotifier<WeeklyTrendingState> {
  WeeklyTrendingNotifier(this.weeklyTrending) : super(WeeklyTrendingInitial());

  final GetWeeklyTrending weeklyTrending;

  void fetchTrending() async {
    state = WeeklyTrendingLoading();
    final result = await weeklyTrending(NoParams());
    result.fold(
      (failure) => state = WeeklyTrendingError(mapFailureToMessage(failure)),
      (trivia) => state = WeeklyTrendingLoaded(trivia),
    );
  }
}
