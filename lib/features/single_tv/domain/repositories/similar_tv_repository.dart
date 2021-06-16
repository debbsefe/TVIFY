import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/tv_list/tv_list.dart';

abstract class SimilarTvRepository {
  Future<Either<Failure, List<TvList>>> getSimilarTv(String id);
}
