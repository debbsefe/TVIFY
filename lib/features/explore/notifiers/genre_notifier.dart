import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/features/explore/data/repositories/genre_repository.dart';

final genreNotiferProvider =
    StateNotifierProvider<GenreNotifier, LoadingState>((ref) {
  return GenreNotifier(ref.watch(genreRepositoryProvider))..init();
});

class GenreNotifier extends StateNotifier<LoadingState> {
  GenreNotifier(this.genreRepository) : super(const LoadingState.idle());

  final GenreRepository genreRepository;
  final logger = Logger('GenreNotifier');

  Future<void> init() async {
    try {
      state = const LoadingState.loading();
      final category = await genreRepository.getGenres();
      state = LoadingState.success(category);
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
