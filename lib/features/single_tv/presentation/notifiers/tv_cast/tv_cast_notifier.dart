import 'package:tvify/core/core.dart';
import 'package:tvify/features/single_tv/data/repositories/tv_cast_repository.dart';

final tvCastNotifierProvider = StateNotifierProvider.family
    .autoDispose<TvCastNotifier, LoadingState, String>((ref, String id) {
  return TvCastNotifier(ref.watch(tvCastRepositoryProvider))..init(id);
});

class TvCastNotifier extends StateNotifier<LoadingState> {
  TvCastNotifier(this.tvCastRepository) : super(const LoadingState.idle());

  final TvCastRepository tvCastRepository;
  final logger = Logger('TvCastNotifier');

  Future<void> init(String id) async {
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
