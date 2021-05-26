import 'package:equatable/equatable.dart';

import '../../../configuration/domain/entities/configuration.dart';

abstract class ConfigurationState extends Equatable {
  ConfigurationState();
}

class ConfigurationInitial extends ConfigurationState {
  ConfigurationInitial();

  @override
  List<Object> get props => [];
}

class ConfigurationLoading extends ConfigurationState {
  ConfigurationLoading();

  @override
  List<Object> get props => [];
}

class ConfigurationLoaded extends ConfigurationState {
  final AppConfiguration configuration;
  ConfigurationLoaded(this.configuration);

  @override
  List<Object> get props => [configuration];
}

class ConfigurationError extends ConfigurationState {
  final String message;
  ConfigurationError(this.message);

  @override
  List<Object> get props => [message];
}
