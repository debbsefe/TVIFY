import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/tv_list/tv_list.dart';

abstract class TrendingRepository {
  Future<Either<Failure, List<TvList>>> getTrendingDaily();

  Future<Either<Failure, List<TvList>>> getTrendingWeekly();
}
