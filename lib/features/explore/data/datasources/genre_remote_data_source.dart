import 'package:http/http.dart' as http;
import 'package:tvify/core/core.dart';
import 'package:tvify/core/utils/extensions.dart';
import 'package:tvify/features/explore/data/datasources/genre_local_data_source.dart';

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
