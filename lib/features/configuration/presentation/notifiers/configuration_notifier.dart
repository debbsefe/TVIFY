import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/usecases/get_configuration.dart';
import 'configuration_state.dart';

class ConfigurationNotifier extends StateNotifier<ConfigurationState> {
  ConfigurationNotifier(this.allConfiguration) : super(ConfigurationInitial());

  final GetAllConfiguration allConfiguration;

  void fetchConfiguration() async {
    state = ConfigurationLoading();
    final result = await allConfiguration(NoParams());
    result.fold(
      (failure) => state = ConfigurationError(mapFailureToMessage(failure)),
      (result) => state = ConfigurationLoaded(result),
    );
  }

  ConfigurationState currentState() {
    return state;
  }

  String fetchPosterSizeUrl() {
    var current = currentState();
    if (current is ConfigurationLoaded) {
      return '${current.configuration.secureBaseUrl}${current.configuration.posterSizes[4]}/';
    } else {
      return 'https://image.tmdb.org/t/p/w500/';
    }
  }
}
