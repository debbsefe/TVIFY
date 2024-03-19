import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/single_tv/data/repositories/similar_tv_repository.dart';

final getSimilarTvProvider = Provider<GetSimilarTv>((ref) {
  return GetSimilarTv(ref.watch(similarTvRepositoryProvider));
});

class GetSimilarTv extends UseCase<TvList, Params> {
  GetSimilarTv(this.repository);

  final SimilarTvRepository repository;

  @override
  Future<Either<Failure, TvList>> call(Params params) async {
    return repository.getSimilarTv(params.id);
  }
}

class Params extends Equatable {
  const Params({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
