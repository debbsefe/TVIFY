// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';

import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';
import 'package:movie_colony/features/categories/domain/repositories/categories_repository.dart';

class GetAllCategories extends UseCase<List<Categories>, NoParams> {
  GetAllCategories(this.repository);

  final CategoriesRepository repository;

  @override
  Future<Either<Failure, List<Categories>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
