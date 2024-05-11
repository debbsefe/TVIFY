import 'package:http/http.dart' as http;
import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/core/utils/extensions.dart';

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

  Future<TvListModel?> getRemoteTrendingDaily({int page = 1}) async {
    final Uri uri = Uri.parse('trending/tv/day?page=$page'.baseurl);
    final response = await client.get(uri);
    return tvListModelFromJson(response.body);
  }

  Future<TvListModel?> getAiringToday({int page = 1}) async {
    final Uri uri = Uri.parse('tv/airing_today?page=$page'.baseurl);
    final response = await client.get(uri);
    return tvListModelFromJson(response.body);
  }
}
