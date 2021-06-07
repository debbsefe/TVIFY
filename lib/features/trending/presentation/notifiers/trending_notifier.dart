import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/usecases/get_trending.dart';

import 'trending_state.dart';

class TrendingNotifier extends StateNotifier<TrendingState> {
  TrendingNotifier(this.allTrending) : super(TrendingInitial());

  final GetAllTrending allTrending;

  void fetchTrending() async {
    state = TrendingLoading();
    final result = await allTrending(NoParams());
    result.fold(
      (failure) => state = TrendingError(mapFailureToMessage(failure)),
      (trivia) => state = TrendingLoaded(trivia),
    );
  }
}
