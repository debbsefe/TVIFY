import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/single_tv/data/repositories/tv_cast_repository.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_cast.dart';

final tvCastNotifierProvider =
    StateNotifierProvider<TvCastNotifier, GenericState<List<TvCast>>>((ref) {
  return TvCastNotifier(ref.watch(tvCastRepositoryProvider));
});

class TvCastNotifier extends GenericStateNotifier<List<TvCast>> {
  TvCastNotifier(this.tvCastRepository);

  final TvCastRepository tvCastRepository;

  void fetchTvCast(String id) {
    sendRequest(() async {
      return tvCastRepository.getTvCast(id);
    });
  }
}
