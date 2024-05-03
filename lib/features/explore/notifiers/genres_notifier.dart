import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/features/explore/data/repositories/genres_repository.dart';

final genresNotiferProvider =
    StateNotifierProvider<GenresNotifier, LoadingState>((ref) {
  return GenresNotifier(ref.watch(genresRepositoryProvider))..init();
});

class GenresNotifier extends StateNotifier<LoadingState> {
  GenresNotifier(this.genreRepository) : super(const LoadingState.idle());

  final GenreRepository genreRepository;
  final logger = Logger('GenresNotifier');

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
