import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/trending/data/repositories/trending_repository_impl.dart';

final getDailyTrendingProvider = Provider<GetDailyTrending>((ref) {
  return GetDailyTrending(ref.watch(trendingRepositoryProvider));
});

class GetDailyTrending extends UseCase<TvList, NoParams> {
  GetDailyTrending(this.repository);

  final TrendingRepository repository;

  @override
  Future<Either<Failure, TvList>> call(NoParams params) async {
    return repository.getTrendingDaily();
  }
}
