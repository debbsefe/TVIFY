import 'package:equatable/equatable.dart';

import '../../../configuration/domain/entities/configuration.dart';

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

  final Configuration configuration;

  @override
  List<Object> get props => [configuration];
}

class ConfigurationError extends ConfigurationState {
  ConfigurationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
