import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/single_tv/data/models/tv_detail_model.dart';

abstract class TvDetailRemoteDataSource {
  Future<TvDetailModel> getRemoteTvDetail(String id);
}

class TvDetailRemoteDataSourceImpl implements TvDetailRemoteDataSource {
  TvDetailRemoteDataSourceImpl({required this.client, required this.config});
  final http.Client client;
  final Config config;

  @override
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
