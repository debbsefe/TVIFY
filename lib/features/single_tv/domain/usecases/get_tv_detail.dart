import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/single_tv/data/repositories/tv_detail_repository_impl.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_detail.dart';

class GetTvDetail extends UseCase<TvDetail, Params> {
  GetTvDetail(this.repository);

  final TvDetailRepository repository;

  Future<Either<Failure, TvDetail>> call(Params params) async {
    return repository.getTvDetail(params.id);
  }
}

class Params extends Equatable {
  const Params({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
