import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/movie_list/movie_list.dart';

abstract class TrendingRepository {
  Future<Either<Failure, List<MovieList>>> getTrendingDaily();

  Future<Either<Failure, List<MovieList>>> getTrendingWeekly();
}
