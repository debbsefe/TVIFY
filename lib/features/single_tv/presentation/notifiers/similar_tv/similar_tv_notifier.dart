import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/single_tv/domain/usecases/get_similar_tv.dart';

final similarTvNotifierProvider =
    StateNotifierProvider<SimilarTvNotifier, GenericState<TvList>>((ref) {
  return SimilarTvNotifier(ref.watch(getSimilarTvProvider));
});

class SimilarTvNotifier extends GenericStateNotifier<TvList> {
  SimilarTvNotifier(this.similarTv);

  final GetSimilarTv similarTv;

  void fetchSimilarTv(String id) {
    sendRequest(() async {
      return similarTv(Params(id: id));
    });
  }
}
