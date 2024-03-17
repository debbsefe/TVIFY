import 'package:dartz/dartz.dart';

import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/configuration/domain/entities/configuration.dart';
import 'package:movie_colony/features/configuration/domain/repositories/configuration_repository.dart';

class GetAllConfiguration extends UseCase<Configuration, NoParams> {
  GetAllConfiguration(this.repository);

  final ConfigurationRepository repository;

  @override
  Future<Either<Failure, Configuration>> call(NoParams params) async {
    return await repository.getConfiguration();
  }
}
