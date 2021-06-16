import 'package:equatable/equatable.dart';

import '../../../../../core/models/tv_list/tv_list.dart';

abstract class SimilarTvState extends Equatable {}

class SimilarTvInitial extends SimilarTvState {
  @override
  List<Object> get props => [];
}

class SimilarTvLoading extends SimilarTvState {
  @override
  List<Object> get props => [];
}

class SimilarTvLoaded extends SimilarTvState {
  SimilarTvLoaded(this.similarTv);

  final List<TvList> similarTv;

  @override
  List<Object> get props => [similarTv];
}

class SimilarTvError extends SimilarTvState {
  SimilarTvError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
