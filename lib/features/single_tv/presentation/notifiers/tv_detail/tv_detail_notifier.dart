import 'package:tvify/core/core.dart';
import 'package:tvify/features/single_tv/data/repositories/tv_detail_repository.dart';

final tvDetailNotifierProvider = StateNotifierProvider.family
    .autoDispose<TvDetailNotifier, LoadingState, String>((ref, String id) {
  return TvDetailNotifier(ref.watch(tvDetailRepositoryProvider))..init(id);
});

class TvDetailNotifier extends StateNotifier<LoadingState> {
  TvDetailNotifier(this.tvDetailRepository) : super(const LoadingState.idle());

  final TvDetailRepository tvDetailRepository;
  final logger = Logger('TvCastNotifier');

  Future<void> init(String id) async {
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
