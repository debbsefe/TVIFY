import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_colony/core/data/data.dart';
import 'package:movie_colony/core/model/model.dart';
import 'package:movie_colony/core/utils/extensions.dart';

final tvCastRemoteDataSourceProvider = Provider<TvCastRemoteDataSource>((ref) {
  return TvCastRemoteDataSource(
    client: ref.watch(httpClientProvider),
  );
});

class TvCastRemoteDataSource {
  TvCastRemoteDataSource({required this.client});
  final http.Client client;

  Future<TvCastModel> getRemoteTvCast(String id) async {
    final String url = 'tv/$id/credits'.baseurl;
    final response = await client.get(Uri.parse(url));

    return tvCastModelFromJson(response.body);
  }
}
