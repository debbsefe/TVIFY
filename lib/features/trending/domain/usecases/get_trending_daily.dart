import 'package:dartz/dartz.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/trending_repository.dart';

class GetDailyTrending extends UseCase<List<TvList>, NoParams> {
  GetDailyTrending(this.repository);

  final TrendingRepository repository;

  @override
  Future<Either<Failure, List<TvList>>> call(NoParams params) async {
    return await repository.getTrendingDaily();
  }
}
