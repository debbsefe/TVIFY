import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/configuration.dart';

abstract class ConfigurationRepository {
  Future<Either<Failure, Configuration>> getConfiguration();
}
