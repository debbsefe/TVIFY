import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/core/repository.dart/shared_preferences_repository.dart';
import 'package:tvfiy/core/utils/strings.dart';
import 'package:tvfiy/features/explore/data/datasources/genre_local_data_source.dart';
import 'package:tvfiy/features/explore/data/datasources/genre_remote_data_source.dart';

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
