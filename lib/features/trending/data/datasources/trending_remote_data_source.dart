import 'package:http/http.dart' as http;
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/utils/extensions.dart';

final trendingRemoteDataSourceProvider =
    Provider<TrendingRemoteDataSource>((ref) {
  return TrendingRemoteDataSource(
    client: ref.watch(httpClientProvider),
  );
});

class TrendingRemoteDataSource {
  TrendingRemoteDataSource({
    required this.client,
  });

  final http.Client client;

  Future<TvListModel?> getRemoteTrendingWeekly() async {
    final Uri uri = Uri.parse('trending/tv/week'.baseurl);
    final response = await client.get(uri);
    return tvListModelFromJson(response.body);
  }

  Future<TvListModel?> getRemoteTrendingDaily() async {
    final Uri uri = Uri.parse('trending/tv/day'.baseurl);
    final response = await client.get(uri);
    return tvListModelFromJson(response.body);
  }
}
