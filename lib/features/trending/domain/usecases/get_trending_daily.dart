import 'package:dartz/dartz.dart';
import 'package:movie_colony/core/models/movie_list/movie_list.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/trending_repository.dart';

class GetDailyTrending extends UseCase<List<MovieList>, NoParams> {
  GetDailyTrending(this.repository);

  final TrendingRepository repository;

  @override
  Future<Either<Failure, List<MovieList>>> call(NoParams params) async {
    return await repository.getTrendingDaily();
  }
}
