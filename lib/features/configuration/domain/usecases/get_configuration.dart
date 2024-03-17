import 'package:dartz/dartz.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/configuration/data/repositories/configuration_repository_impl.dart';
import 'package:movie_colony/features/configuration/domain/entities/configuration.dart';

class GetAllConfiguration extends UseCase<Configuration, NoParams> {
  GetAllConfiguration(this.repository);

  final ConfigurationRepository repository;

  @override
  Future<Either<Failure, Configuration>> call(NoParams params) async {
    return repository.getConfiguration();
  }
}
