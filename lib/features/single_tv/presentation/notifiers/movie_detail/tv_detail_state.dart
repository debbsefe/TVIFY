import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_detail.dart';

abstract class TvDetailState extends Equatable {}

class TvDetailInitial extends TvDetailState {
  @override
  List<Object> get props => [];
}

class TvDetailLoading extends TvDetailState {
  @override
  List<Object> get props => [];
}

class TvDetailLoaded extends TvDetailState {
  TvDetailLoaded(this.tvDetail);

  final TvDetail tvDetail;

  @override
  List<Object> get props => [tvDetail];
}

class TvDetailError extends TvDetailState {
  TvDetailError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
