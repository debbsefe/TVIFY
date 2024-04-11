import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/features/categories/data/repositories/categories_repository.dart';

final categoriesNotiferProvider =
    StateNotifierProvider<CategoriesNotifier, LoadingState>((ref) {
  return CategoriesNotifier(ref.watch(categoriesRepositoryProvider))..init();
});

class CategoriesNotifier extends StateNotifier<LoadingState> {
  CategoriesNotifier(this.categoriesRepository)
      : super(const LoadingState.idle());

  final CategoriesRepository categoriesRepository;
  final logger = Logger('CategoriesNotifier');

  Future<void> init() async {
    try {
      state = const LoadingState.loading();
      final category = await categoriesRepository.getCategories();
      state = LoadingState.success(category);
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
