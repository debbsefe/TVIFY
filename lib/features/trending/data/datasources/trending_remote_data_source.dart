import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/models/movie_list/movie_list_model.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/strings.dart';

abstract class TrendingRemoteDataSource {
  Future<List<MovieListModel>> getRemoteTrendingWeekly();
  Future<List<MovieListModel>> getRemoteTrendingDaily();
}

class TrendingRemoteDataSourceImpl implements TrendingRemoteDataSource {
  TrendingRemoteDataSourceImpl({required this.client, required this.config});

  final http.Client client;
  final Config config;

  @override
  Future<List<MovieListModel>> getRemoteTrendingWeekly() async {
    String _token = await config.fetchToken(Strings.apiKeyTmdb);
    String _url = 'trending/tv/week?api_key=$_token'.baseurl;
    final response = await client.get(
      Uri.parse(_url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return parsed['results']
          .map<MovieListModel>((json) => MovieListModel.fromJson(json))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieListModel>> getRemoteTrendingDaily() async {
    String _token = await config.fetchToken(Strings.apiKeyTmdb);
    String _url = 'trending/tv/day?api_key=$_token'.baseurl;
    final response = await client.get(
      Uri.parse(_url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return parsed['results']
          .map<MovieListModel>((json) => MovieListModel.fromJson(json))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
