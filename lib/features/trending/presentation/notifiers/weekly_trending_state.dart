import 'package:equatable/equatable.dart';

import '../../../../core/models/movie_list/movie_list.dart';

abstract class WeeklyTrendingState extends Equatable {}

class WeeklyTrendingInitial extends WeeklyTrendingState {
  @override
  List<Object> get props => [];
}

class WeeklyTrendingLoading extends WeeklyTrendingState {
  @override
  List<Object> get props => [];
}

class WeeklyTrendingLoaded extends WeeklyTrendingState {
  WeeklyTrendingLoaded(this.weeklyTrending);

  final List<MovieList> weeklyTrending;

  @override
  List<Object> get props => [weeklyTrending];
}

class WeeklyTrendingError extends WeeklyTrendingState {
  WeeklyTrendingError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
