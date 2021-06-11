import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/movie_list/movie_list.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/trending_repository.dart';

class GetWeeklyTrending extends UseCase<List<MovieList>, NoParams> {
  GetWeeklyTrending(this.repository);

  final TrendingRepository repository;

  @override
  Future<Either<Failure, List<MovieList>>> call(NoParams params) async {
    return await repository.getTrendingWeekly();
  }
}
