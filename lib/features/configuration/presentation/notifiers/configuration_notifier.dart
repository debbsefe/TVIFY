import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/configuration/domain/entities/configuration.dart';
import 'package:movie_colony/features/configuration/domain/usecases/get_configuration.dart';

final configurationNotifierProvider =
    StateNotifierProvider<ConfigurationNotifier, GenericState<Configuration>>(
        (ref) {
  return ConfigurationNotifier(
    allConfiguration: ref.watch(getAllConfigurationProvider),
  );
});

class ConfigurationNotifier extends GenericStateNotifier<Configuration> {
  ConfigurationNotifier({required this.allConfiguration});

  final GetAllConfiguration allConfiguration;

  void fetchConfiguration() {
    sendRequest(() async {
      return allConfiguration(NoParams());
    });
  }

  GenericState<Configuration> currentState() {
    return state;
  }

  String fetchPosterSizeUrl() {
    final current = currentState();
    if (current is Loaded<Configuration>) {
      return '${current.value!.secureBaseUrl}${current.value!.posterSizes[4]}/';
    } else {
      return 'https://image.tmdb.org/t/p/w500/';
    }
  }

  String fetchProfileSizeUrl() {
    final current = currentState();
    if (current is Loaded<Configuration>) {
      return '${current.value!.secureBaseUrl}${current.value!.profileSizes[3]}/';
    } else {
      return 'https://image.tmdb.org/t/p/original/';
    }
  }
}
