import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/single_tv/data/repositories/tv_detail_repository.dart';

final tvDetailNotifierProvider =
    StateNotifierProvider<TvDetailNotifier, GenericState<TvDetailModel>>((ref) {
  return TvDetailNotifier(ref.watch(tvDetailRepositoryProvider));
});

class TvDetailNotifier extends GenericStateNotifier<TvDetailModel> {
  TvDetailNotifier(this.tvDetailRepository);

  final TvDetailRepository tvDetailRepository;

  void fetchTvDetail(String id) {
    sendRequest(() async {
      return tvDetailRepository.getTvDetail(id);
    });
  }
}
