import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/strings.dart';
import '../../../domain/usecases/get_similar_tv.dart';
import 'similar_tv_state.dart';

class SimilarTvNotifier extends StateNotifier<SimilarTvState> {
  SimilarTvNotifier(this.similarTv) : super(SimilarTvInitial());

  final GetSimilarTv similarTv;

  void fetchSimilarTv(String id) async {
    state = SimilarTvLoading();
    final result = await similarTv(Params(id: id));
    result.fold(
      (failure) => state = SimilarTvError(mapFailureToMessage(failure)),
      (result) => state = SimilarTvLoaded(result),
    );
  }
}
