import 'package:equatable/equatable.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';

abstract class DailyTrendingState extends Equatable {}

class DailyTrendingInitial extends DailyTrendingState {
  @override
  List<Object> get props => [];
}

class DailyTrendingLoading extends DailyTrendingState {
  @override
  List<Object> get props => [];
}

class DailyTrendingLoaded extends DailyTrendingState {
  DailyTrendingLoaded(this.dailyTrending);

  final List<TvList> dailyTrending;

  @override
  List<Object> get props => [dailyTrending];
}

class DailyTrendingError extends DailyTrendingState {
  DailyTrendingError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
