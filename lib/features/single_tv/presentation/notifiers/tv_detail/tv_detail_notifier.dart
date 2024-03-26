import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/features/single_tv/data/repositories/tv_detail_repository.dart';

final tvDetailNotifierProvider =
    StateNotifierProvider<TvDetailNotifier, LoadingState>((ref) {
  return TvDetailNotifier(ref.watch(tvDetailRepositoryProvider));
});

class TvDetailNotifier extends StateNotifier<LoadingState> {
  TvDetailNotifier(this.tvDetailRepository) : super(const LoadingState.idle());

  final TvDetailRepository tvDetailRepository;
  final logger = Logger('TvCastNotifier');

  Future<void> fetchTvDetail(String id) async {
    try {
      state = const LoadingState.loading();
      final result = await tvDetailRepository.getTvDetail(id);
      state = LoadingState.success(result);
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
