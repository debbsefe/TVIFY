import 'package:dartz/dartz.dart';

import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';

abstract class TrendingRepository {
  Future<Either<Failure, List<TvList>>> getTrendingDaily();

  Future<Either<Failure, List<TvList>>> getTrendingWeekly();
}
