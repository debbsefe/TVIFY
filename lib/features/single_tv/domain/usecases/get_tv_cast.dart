import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/single_tv/data/repositories/tv_cast_repository.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_cast.dart';

final getTvCastProvider = Provider<GetTvCast>((ref) {
  return GetTvCast(ref.watch(tvCastRepositoryProvider));
});

class GetTvCast extends UseCase<List<TvCast>, Params> {
  GetTvCast(this.repository);

  final TvCastRepository repository;

  @override
  Future<Either<Failure, List<TvCast>>> call(Params params) async {
    return repository.getTvCast(params.id);
  }
}

class Params extends Equatable {
  const Params({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
