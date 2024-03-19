import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/single_tv/data/models/tv_detail_model.dart';
import 'package:movie_colony/providers.dart';

final tvDetailRemoteDataSourceProvider =
    Provider<TvDetailRemoteDataSource>((ref) {
  return TvDetailRemoteDataSource(
    client: ref.watch(httpClientProvider),
    config: ref.watch(configProvider),
  );
});

class TvDetailRemoteDataSource {
  TvDetailRemoteDataSource({required this.client, required this.config});
  final http.Client client;
  final Config config;

  Future<TvDetailModel> getRemoteTvDetail(String id) async {
    final String token = await config.fetchToken(Strings.apiKeyTmdb);
    final String url = 'tv/$id?api_key=$token'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }
}
