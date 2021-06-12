import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/tv_cast.dart';

abstract class TvCastRepository {
  Future<Either<Failure, List<TvCast>>> getTvCast(String id);
}
