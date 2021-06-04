import 'package:equatable/equatable.dart';
import '../../domain/entities/trending.dart';

abstract class TrendingState extends Equatable {}

class TrendingInitial extends TrendingState {
  @override
  List<Object> get props => [];
}

class TrendingLoading extends TrendingState {
  @override
  List<Object> get props => [];
}

class TrendingLoaded extends TrendingState {
  TrendingLoaded(this.trending);

  final List<Trending> trending;

  @override
  List<Object> get props => [trending];
}

class TrendingError extends TrendingState {
  TrendingError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
