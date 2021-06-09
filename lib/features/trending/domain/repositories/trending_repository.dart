import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/trending.dart';

abstract class TrendingRepository {
  Future<Either<Failure, List<Trending>>> getTrendingDaily();

  Future<Either<Failure, List<Trending>>> getTrendingWeekly();
}
