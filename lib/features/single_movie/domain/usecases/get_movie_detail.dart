// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_detail_repository.dart';

class GetMovieDetail extends UseCase<MovieDetail, Params> {
  GetMovieDetail(this.repository);

  final MovieDetailRepository repository;

  @override
  Future<Either<Failure, MovieDetail>> call(Params params) async {
    return await repository.getMovieDetail(params.id);
  }
}

class Params extends Equatable {
  const Params({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
