import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_colony/core/config.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_local_data_source.dart';
import 'package:movie_colony/features/categories/data/models/categories_model.dart';
import 'package:movie_colony/providers.dart';

final categoriesRemoteDataSourceProvider =
    Provider<CategoriesRemoteDataSource>((ref) {
  return CategoriesRemoteDataSource(
    client: ref.watch(httpClientProvider),
    config: ref.watch(configProvider),
    localDataSource: ref.watch(categoriesLocalDataSourceProvider),
  );
});

class CategoriesRemoteDataSource {
  CategoriesRemoteDataSource({
    required this.client,
    required this.config,
    required this.localDataSource,
  });

  final http.Client client;
  final Config config;
  final CategoriesLocalDataSource localDataSource;

  Future<List<CategoriesModel>> getRemoteCategories() async {
    final String token = await config.fetchToken(Strings.apiKeyTmdb);
    final String url = 'genre/tv/list?api_key=$token&language=en-US'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return (parsed['genres'] as List)
          .map<CategoriesModel>(
            (item) => CategoriesModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } else {
      return localDataSource.getCachedCategory();
    }
  }
}
