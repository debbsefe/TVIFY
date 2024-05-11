import 'package:http/http.dart' as http;
import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/core/utils/extensions.dart';
import 'package:tvfiy/features/explore/data/datasources/genre_local_data_source.dart';

final exploreRemoteDataSourceProvider =
    Provider<ExploreRemoteDataSource>((ref) {
  return ExploreRemoteDataSource(
    client: ref.watch(httpClientProvider),
    localDataSource: ref.watch(genreLocalDataSourceProvider),
  );
});

class ExploreRemoteDataSource {
  ExploreRemoteDataSource({
    required this.client,
    required this.localDataSource,
  });

  final http.Client client;
  final GenreLocalDataSource localDataSource;

  Future<TvListModel?> discoverTVByGenre(int genreId, int page) async {
    final Uri uri =
        Uri.parse('/discover/tv?page=$page&with_genres=$genreId'.baseurl);

    final response = await client.get(uri);

    return tvListModelFromJson(response.body);
  }

  Future<TvListModel?> searchTV(String query, int page) async {
    final Uri uri = Uri.parse('search/tv?query=$query&page=$page'.baseurl);
    final response = await client.get(uri);
    return tvListModelFromJson(response.body);
  }
}
