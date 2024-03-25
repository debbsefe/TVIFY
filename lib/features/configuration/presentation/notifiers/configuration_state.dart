import 'package:equatable/equatable.dart';
import 'package:movie_colony/core/core.dart';

abstract class ConfigurationState extends Equatable {}

class ConfigurationInitial extends ConfigurationState {
  @override
  List<Object> get props => [];
}

class ConfigurationLoading extends ConfigurationState {
  @override
  List<Object> get props => [];
}

class ConfigurationLoaded extends ConfigurationState {
  ConfigurationLoaded(this.configuration);

  final ConfigurationModel configuration;

  @override
  List<Object> get props => [configuration];
}

class ConfigurationError extends ConfigurationState {
  ConfigurationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
