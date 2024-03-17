// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';

import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<Categories>>> getCategories();
}
