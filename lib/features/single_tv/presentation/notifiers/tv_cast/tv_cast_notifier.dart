import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/single_tv/data/repositories/tv_cast_repository.dart';

final tvCastNotifierProvider =
    StateNotifierProvider<TvCastNotifier, GenericState<TvCastModel>>((ref) {
  return TvCastNotifier(ref.watch(tvCastRepositoryProvider));
});

class TvCastNotifier extends GenericStateNotifier<TvCastModel> {
  TvCastNotifier(this.tvCastRepository);

  final TvCastRepository tvCastRepository;

  void fetchTvCast(String id) {
    sendRequest(() async {
      return tvCastRepository.getTvCast(id);
    });
  }
}
