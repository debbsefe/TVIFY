import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_colony/features/single_tv/data/models/tv_cast_model.dart';

import '../../../../core/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/strings.dart';

abstract class TvCastRemoteDataSource {
  Future<TvCastModel> getRemoteTvCast(String id);
}

class TvCastRemoteDataSourceImpl implements TvCastRemoteDataSource {
  TvCastRemoteDataSourceImpl({required this.client, required this.config});
  final http.Client client;
  final Config config;

  @override
  Future<TvCastModel> getRemoteTvCast(String id) async {
    String _token = await config.fetchToken(Strings.apiKeyTmdb);
    String _url = 'tv/$id/credits?api_key=$_token'.baseurl;
    final response = await client.get(
      Uri.parse(_url),
    );

    if (response.statusCode == 200) {
      return TvCastModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw ServerException();
    }
  }
}
