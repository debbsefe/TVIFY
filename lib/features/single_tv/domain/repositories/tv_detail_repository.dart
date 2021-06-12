import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/tv_detail.dart';

abstract class TvDetailRepository {
  Future<Either<Failure, TvDetail>> getTvDetail(String id);
}
