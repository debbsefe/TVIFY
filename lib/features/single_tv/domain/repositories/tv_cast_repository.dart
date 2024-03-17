import 'package:dartz/dartz.dart';

import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_cast.dart';

abstract class TvCastRepository {
  Future<Either<Failure, List<TvCast>>> getTvCast(String id);
}
