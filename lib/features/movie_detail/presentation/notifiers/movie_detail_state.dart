import 'package:equatable/equatable.dart';

import '../../domain/entities/movie_detail.dart';

abstract class MovieDetailState extends Equatable {}

class MovieDetailInitial extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailLoading extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailLoaded extends MovieDetailState {
  MovieDetailLoaded(this.movieDetail);

  final MovieDetail movieDetail;

  @override
  List<Object> get props => [movieDetail];
}

class MovieDetailError extends MovieDetailState {
  MovieDetailError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
