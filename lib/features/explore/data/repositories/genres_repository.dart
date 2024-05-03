import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/explore/data/datasources/Genres_local_data_source.dart';
import 'package:movie_colony/features/explore/data/datasources/genres_remote_data_source.dart';

final genresRepositoryProvider = Provider<GenreRepository>((ref) {
  return GenreRepository(
    localDataSource: ref.watch(genresLocalDataSourceProvider),
    sharedPreferencesRepository: ref.watch(sharedPreferencesRepositoryProvider),
    remoteDataSource: ref.watch(genresRemoteDataSourceProvider),
  );
});

class GenreRepository {
  GenreRepository({
    required this.sharedPreferencesRepository,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  final GenresRemoteDataSource remoteDataSource;
  final GenresLocalDataSource localDataSource;
  final SharedPreferencesRepository sharedPreferencesRepository;

  Future<GenreModel?> getGenres() async {
    final bool hasExpired =
        sharedPreferencesRepository.shouldRenewCache(Strings.cachedCategory);
    return hasExpired ? await remoteData() : localData();
  }

  Future<GenreModel?> remoteData() async {
    final remote = await remoteDataSource.getRemoteGenres();
    await localDataSource.cacheLastCategory(remote);
    return remote;
  }

  GenreModel? localData() {
    return localDataSource.getCachedCategory();
  }
}
