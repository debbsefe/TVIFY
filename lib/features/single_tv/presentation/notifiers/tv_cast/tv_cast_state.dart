import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_cast.dart';

abstract class TvCastState extends Equatable {}

class TvCastInitial extends TvCastState {
  @override
  List<Object> get props => [];
}

class TvCastLoading extends TvCastState {
  @override
  List<Object> get props => [];
}

class TvCastLoaded extends TvCastState {
  TvCastLoaded(this.tvCast);

  final List<TvCast> tvCast;

  @override
  List<Object> get props => [tvCast];
}

class TvCastError extends TvCastState {
  TvCastError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
