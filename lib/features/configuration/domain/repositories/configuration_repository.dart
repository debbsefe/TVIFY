// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/configuration.dart';

abstract class ConfigurationRepository {
  Future<Either<Failure, AppConfiguration>> getConfiguration();
}
