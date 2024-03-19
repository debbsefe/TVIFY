// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';

final getAllCategoriesProvider = Provider<GetAllCategories>((ref) {
  return GetAllCategories(ref.watch(categoriesRepositoryProvider));
});

class GetAllCategories extends UseCase<List<Categories>, NoParams> {
  GetAllCategories(this.repository);

  final CategoriesRepository repository;

  @override
  Future<Either<Failure, List<Categories>>> call(NoParams params) async {
    return repository.getCategories();
  }
}
