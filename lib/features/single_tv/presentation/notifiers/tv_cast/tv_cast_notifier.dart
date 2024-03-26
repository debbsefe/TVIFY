import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/features/single_tv/data/repositories/tv_cast_repository.dart';

final tvCastNotifierProvider =
    StateNotifierProvider<TvCastNotifier, LoadingState>((ref) {
  return TvCastNotifier(ref.watch(tvCastRepositoryProvider));
});

class TvCastNotifier extends StateNotifier<LoadingState> {
  TvCastNotifier(this.tvCastRepository) : super(const LoadingState.idle());

  final TvCastRepository tvCastRepository;
  final logger = Logger('TvCastNotifier');

  Future<void> fetchTvCast(String id) async {
    try {
      state = const LoadingState.loading();
      final result = await tvCastRepository.getTvCast(id);
      state = LoadingState.success(result);
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
