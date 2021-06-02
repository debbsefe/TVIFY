// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/configuration.dart';
import '../repositories/configuration_repository.dart';

class GetAllConfiguration extends UseCase<Configuration, NoParams> {
  GetAllConfiguration(this.repository);

  final ConfigurationRepository repository;

  @override
  Future<Either<Failure, Configuration>> call(NoParams params) async {
    return await repository.getConfiguration();
  }
}
