import 'package:equatable/equatable.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';

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

  final List<TvList> weeklyTrending;

  @override
  List<Object> get props => [weeklyTrending];
}

class WeeklyTrendingError extends WeeklyTrendingState {
  WeeklyTrendingError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
