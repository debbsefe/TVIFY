import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_detail.dart';
import 'package:movie_colony/features/single_tv/domain/usecases/get_tv_detail.dart';

final tvDetailNotifierProvider =
    StateNotifierProvider<TvDetailNotifier, GenericState<TvDetail>>((ref) {
  return TvDetailNotifier(ref.watch(getTvDetailProvider));
});

class TvDetailNotifier extends GenericStateNotifier<TvDetail> {
  TvDetailNotifier(this.tvDetail);

  final GetTvDetail tvDetail;

  void fetchTvDetail(String id) {
    sendRequest(() async {
      return tvDetail(Params(id: id));
    });
  }
}
