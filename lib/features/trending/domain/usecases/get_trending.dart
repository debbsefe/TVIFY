import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/trending.dart';
import '../repositories/trending_repository.dart';

class GetAllTrending extends UseCase<List<Trending>, NoParams> {
  GetAllTrending(this.repository);

  final TrendingRepository repository;

  @override
  Future<Either<Failure, List<Trending>>> call(NoParams params) async {
    return await repository.getTrending();
  }
}
