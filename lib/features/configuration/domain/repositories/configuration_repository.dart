import 'package:dartz/dartz.dart';

import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/features/configuration/domain/entities/configuration.dart';

abstract class ConfigurationRepository {
  Future<Either<Failure, Configuration>> getConfiguration();
}
