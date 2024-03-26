import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/features/single_tv/data/repositories/similar_tv_repository.dart';

final similarTvNotifierProvider =
    StateNotifierProvider<SimilarTvNotifier, LoadingState>((ref) {
  return SimilarTvNotifier(ref.watch(similarTvRepositoryProvider));
});

class SimilarTvNotifier extends StateNotifier<LoadingState> {
  SimilarTvNotifier(this.similarTvRepository)
      : super(const LoadingState.idle());

  final SimilarTvRepository similarTvRepository;
  final logger = Logger('SimilarTvNotifier');

  Future<void> fetchSimilarTv(String id) async {
    try {
      state = const LoadingState.loading();
      final result = await similarTvRepository.getSimilarTv(id);
      state = LoadingState.success(result);
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
