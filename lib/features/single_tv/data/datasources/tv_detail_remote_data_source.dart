import 'package:http/http.dart' as http;
import 'package:tvfiy/core/core.dart';
import 'package:tvfiy/core/utils/extensions.dart';

final tvDetailRemoteDataSourceProvider =
    Provider<TvDetailRemoteDataSource>((ref) {
  return TvDetailRemoteDataSource(
    client: ref.watch(httpClientProvider),
  );
});

class TvDetailRemoteDataSource {
  TvDetailRemoteDataSource({required this.client});
  final http.Client client;

  Future<TvDetailModel> getRemoteTvDetail(String id) async {
    final String url = 'tv/$id'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );
    return tvDetailModelFromJson(response.body);
  }
}
