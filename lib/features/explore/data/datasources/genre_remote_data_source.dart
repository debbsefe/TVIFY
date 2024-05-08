import 'package:http/http.dart' as http;
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/features/explore/data/datasources/genre_local_data_source.dart';

final genreRemoteDataSourceProvider = Provider<GenreRemoteDataSource>((ref) {
  return GenreRemoteDataSource(
    client: ref.watch(httpClientProvider),
    localDataSource: ref.watch(genreLocalDataSourceProvider),
  );
});

class GenreRemoteDataSource {
  GenreRemoteDataSource({
    required this.client,
    required this.localDataSource,
  });

  final http.Client client;
  final GenreLocalDataSource localDataSource;

  Future<GenreModel?> getRemoteGenres() async {
    final String url = 'genre/tv/list?language=en-US'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );

    return genreModelFromJson(response.body);
  }
}
