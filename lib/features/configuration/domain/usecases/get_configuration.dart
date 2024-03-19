import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/configuration/data/repositories/configuration_repository.dart';
import 'package:movie_colony/features/configuration/domain/entities/configuration.dart';

final getAllConfigurationProvider = Provider<GetAllConfiguration>((ref) {
  return GetAllConfiguration(ref.watch(configurationRepositoryProvider));
});

class GetAllConfiguration extends UseCase<Configuration, NoParams> {
  GetAllConfiguration(this.repository);

  final ConfigurationRepository repository;

  @override
  Future<Either<Failure, Configuration>> call(NoParams params) async {
    return repository.getConfiguration();
  }
}
