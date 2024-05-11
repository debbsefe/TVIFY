import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/features/explore/data/datasources/explore_remote_data_source.dart';

final exploreNotiferProvider =
    StateNotifierProvider<ExploreNotifier, LoadingState>((ref) {
  return ExploreNotifier(
    ref.watch(exploreRemoteDataSourceProvider),
  );
});

class ExploreNotifier extends StateNotifier<LoadingState> {
  ExploreNotifier(this.dataSource) : super(const LoadingState.idle());

  final ExploreRemoteDataSource dataSource;
  final logger = Logger('ExploreNotifier');

  Future<void> discoverTVByGenre({
    required int genreId,
    int page = 1,
  }) async {
    try {
      state = const LoadingState.loading();
      final result = await dataSource.discoverTVByGenre(genreId, page);
      state = LoadingState.success(result);
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }
}
