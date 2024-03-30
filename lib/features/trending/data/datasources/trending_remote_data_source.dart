import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_local_data_source.dart';

final trendingRemoteDataSourceProvider =
    Provider<TrendingRemoteDataSource>((ref) {
  return TrendingRemoteDataSource(
    client: ref.watch(httpClientProvider),
    localDataSource: ref.watch(trendingLocalDataSourceProvider),
  );
});

class TrendingRemoteDataSource {
  TrendingRemoteDataSource({
    required this.client,
    required this.localDataSource,
  });

  final http.Client client;
  final TrendingLocalDataSource localDataSource;

  Future<TvListModel?> getRemoteTrendingWeekly() async {
    final String url = 'trending/tv/week'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return TvListModel.fromJson(parsed as Map<String, dynamic>);
    } else {
      return localDataSource.getCachedTrendingWeekly();
    }
  }

  Future<TvListModel?> getRemoteTrendingDaily() async {
    final String url = 'trending/tv/day'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return TvListModel.fromJson(parsed as Map<String, dynamic>);
    } else {
      return localDataSource.getCachedTrendingDaily();
    }
  }
}
