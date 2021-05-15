import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/categories.dart';
import '../repositories/categories_repository.dart';

class GetAllCategories extends UseCase<List<Categories>, NoParams> {
  final CategoriesRepository repository;

  GetAllCategories(this.repository);
  @override
  Future<Either<Failure, List<Categories>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
