import 'package:equatable/equatable.dart';
import 'package:movie_colony/features/trending/domain/entities/trending.dart';

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

  final List<Trending> weeklyTrending;

  @override
  List<Object> get props => [weeklyTrending];
}

class WeeklyTrendingError extends WeeklyTrendingState {
  WeeklyTrendingError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
