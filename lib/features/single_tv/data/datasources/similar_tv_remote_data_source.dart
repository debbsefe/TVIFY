import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_colony/core/data/data.dart';
import 'package:movie_colony/core/model/tv_list.dart';
import 'package:movie_colony/core/utils/extensions.dart';

final similarTvRemoteDataSourceProvider =
    Provider<SimilarTvRemoteDataSource>((ref) {
  return SimilarTvRemoteDataSource(
    client: ref.watch(httpClientProvider),
  );
});

class SimilarTvRemoteDataSource {
  SimilarTvRemoteDataSource({
    required this.client,
  });
  final http.Client client;

  Future<TvList> getRemoteSimilarTv(String id) async {
    final String url = 'tv/$id/similar'.baseurl;
    final response = await client.get(Uri.parse(url));

    final parsed = json.decode(response.body);
    return TvList.fromJson(parsed as Map<String, dynamic>);
  }
}
