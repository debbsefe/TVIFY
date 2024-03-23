import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_local_data_source.dart';
import 'package:movie_colony/providers.dart';

final trendingRemoteDataSourceProvider =
    Provider<TrendingRemoteDataSource>((ref) {
  return TrendingRemoteDataSource(
    client: ref.watch(httpClientProvider),
    config: ref.watch(configProvider),
    localDataSource: ref.watch(trendingLocalDataSourceProvider),
  );
});

class TrendingRemoteDataSource {
  TrendingRemoteDataSource({
    required this.client,
    required this.config,
    required this.localDataSource,
  });

  final http.Client client;
  final Config config;
  final TrendingLocalDataSource localDataSource;

  Future<TvList> getRemoteTrendingWeekly() async {
    final String token = await config.fetchToken(Strings.apiKeyTmdb);
    final String url = 'trending/tv/week?api_key=$token'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return TvList.fromJson(parsed as Map<String, dynamic>);
    } else {
      return localDataSource.getCachedTrendingWeekly();
    }
  }

  Future<TvList> getRemoteTrendingDaily() async {
    final String token = await config.fetchToken(Strings.apiKeyTmdb);
    final String url = 'trending/tv/day?api_key=$token'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return TvList.fromJson(parsed as Map<String, dynamic>);
    } else {
      return localDataSource.getCachedTrendingDaily();
    }
  }
}
