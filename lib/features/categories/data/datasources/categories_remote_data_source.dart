import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/categories/data/models/categories_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoriesModel>> getRemoteCategories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final http.Client client;
  final Config config;

  CategoriesRemoteDataSourceImpl({required this.client, required this.config});

  @override
  Future<List<CategoriesModel>> getRemoteCategories() async {
    String _token = await config.fetchToken(API_KEY_TMDB);
    String _url =
        'https://api.themoviedb.org/3/genre/tv/list?api_key=$_token&language=en-US';
    final response = await client.get(
      Uri.parse(_url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return parsed['genres']
          .map<CategoriesModel>((json) => CategoriesModel.fromJson(json))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
