import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/single_tv/data/repositories/similar_tv_repository.dart';

final similarTvNotifierProvider =
    StateNotifierProvider<SimilarTvNotifier, GenericState<TvList>>((ref) {
  return SimilarTvNotifier(ref.watch(similarTvRepositoryProvider));
});

class SimilarTvNotifier extends GenericStateNotifier<TvList> {
  SimilarTvNotifier(this.similarTvRepository);

  final SimilarTvRepository similarTvRepository;

  void fetchSimilarTv(String id) {
    sendRequest(() async {
      return similarTvRepository.getSimilarTv(id);
    });
  }
}
