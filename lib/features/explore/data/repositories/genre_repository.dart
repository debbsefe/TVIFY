import 'package:tvify/core/core.dart';
import 'package:tvify/core/repository.dart/shared_preferences_repository.dart';
import 'package:tvify/core/utils/strings.dart';
import 'package:tvify/features/explore/data/datasources/genre_local_data_source.dart';
import 'package:tvify/features/explore/data/datasources/genre_remote_data_source.dart';

final genreRepositoryProvider = Provider<GenreRepository>((ref) {
  return GenreRepository(
    localDataSource: ref.watch(genreLocalDataSourceProvider),
    sharedPreferencesRepository: ref.watch(sharedPreferencesRepositoryProvider),
    remoteDataSource: ref.watch(genreRemoteDataSourceProvider),
  );
});

class GenreRepository {
  GenreRepository({
    required this.sharedPreferencesRepository,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  final GenreRemoteDataSource remoteDataSource;
  final GenreLocalDataSource localDataSource;
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
