import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_cast.dart';
import 'package:movie_colony/features/single_tv/domain/repositories/tv_cast_repository.dart';

class GetTvCast extends UseCase<List<TvCast>, Params> {
  GetTvCast(this.repository);

  final TvCastRepository repository;

  @override
  Future<Either<Failure, List<TvCast>>> call(Params params) async {
    return await repository.getTvCast(params.id);
  }
}

class Params extends Equatable {
  const Params({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
