import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/core/utils/strings.dart';

class SimilarTvRemoteDataSource {
  SimilarTvRemoteDataSource({required this.client, required this.config});
  final http.Client client;
  final Config config;

  Future<TvList> getRemoteSimilarTv(String id) async {
    final String token = await config.fetchToken(Strings.apiKeyTmdb);
    final String url = 'tv/$id/similar?api_key=$token'.baseurl;
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return TvList.fromJson(parsed as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }
}
