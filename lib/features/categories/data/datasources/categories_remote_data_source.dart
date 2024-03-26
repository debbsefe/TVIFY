import 'package:http/http.dart' as http;
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/utils/extensions.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_local_data_source.dart';

final categoriesRemoteDataSourceProvider =
    Provider<CategoriesRemoteDataSource>((ref) {
  return CategoriesRemoteDataSource(
    client: ref.watch(httpClientProvider),
    localDataSource: ref.watch(categoriesLocalDataSourceProvider),
  );
});

class CategoriesRemoteDataSource {
  CategoriesRemoteDataSource({
    required this.client,
    required this.localDataSource,
  });

  final http.Client client;
  final CategoriesLocalDataSource localDataSource;

  Future<CategoriesModel?> getRemoteCategories() async {
    final String url = 'genre/tv/list?language=en-US'.baseurl;
    final response = await client.get(
      Uri.parse(url),
    );

    return categoriesModelFromJson(response.body);
  }
}
