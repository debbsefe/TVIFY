import 'package:dartz/dartz.dart';

import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';

abstract class SimilarTvRepository {
  Future<Either<Failure, List<TvList>>> getSimilarTv(String id);
}
