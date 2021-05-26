import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/usecases/get_configuration.dart';
import 'configuration_state.dart';

class ConfigurationNotifier extends StateNotifier<ConfigurationState> {
  final GetAllConfiguration allConfiguration;

  ConfigurationNotifier(this.allConfiguration) : super(ConfigurationInitial());
  void fetchConfiguration() async {
    state = ConfigurationLoading();
    final result = await allConfiguration(NoParams());
    result.fold(
      (failure) => state = ConfigurationError(mapFailureToMessage(failure)),
      (result) => state = ConfigurationLoaded(result),
    );
  }
}