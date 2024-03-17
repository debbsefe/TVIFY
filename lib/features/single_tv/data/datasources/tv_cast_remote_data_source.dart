import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/single_tv/data/models/tv_cast_model.dart';

abstract class TvCastRemoteDataSource {
  Future<List<TvCastModel>> getRemoteTvCast(String id);
}

class TvCastRemoteDataSourceImpl implements TvCastRemoteDataSource {
  TvCastRemoteDataSourceImpl({required this.client, required this.config});
  final http.Client client;
  final Config config;

  @override
  Future<List<TvCastModel>> getRemoteTvCast(String id) async {
    final String token = await config.fetchToken(Strings.apiKeyTmdb);
    final String url = 'tv/$id/credits?api_key=$token'.baseurl;
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      return (parsed['cast'] as List)
          .whereType<Map<String, dynamic>>()
          .map<TvCastModel>(TvCastModel.fromJson)
          .toList();
    } else {
      throw ServerException();
    }
  }
}
