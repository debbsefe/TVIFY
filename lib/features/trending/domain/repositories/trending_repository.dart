import 'package:dartz/dartz.dart';
import 'package:movie_colony/core/models/movie_list/movie_list.dart';

import '../../../../core/error/failure.dart';

abstract class TrendingRepository {
  Future<Either<Failure, List<MovieList>>> getTrendingDaily();

  Future<Either<Failure, List<MovieList>>> getTrendingWeekly();
}
