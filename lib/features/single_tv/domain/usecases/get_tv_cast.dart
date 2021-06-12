import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/tv_cast.dart';
import '../repositories/tv_cast_repository.dart';

class GetTvCast extends UseCase<TvCast, Params> {
  GetTvCast(this.repository);

  final TvCastRepository repository;

  @override
  Future<Either<Failure, TvCast>> call(Params params) async {
    return await repository.getTvCast(params.id);
  }
}

class Params extends Equatable {
  const Params({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
