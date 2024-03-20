import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/configuration/data/repositories/configuration_repository.dart';
import 'package:movie_colony/features/configuration/domain/entities/configuration.dart';

final configurationNotifierProvider =
    StateNotifierProvider<ConfigurationNotifier, GenericState<Configuration>>(
        (ref) {
  return ConfigurationNotifier(
    configurationRepository: ref.watch(configurationRepositoryProvider),
  );
});

class ConfigurationNotifier extends GenericStateNotifier<Configuration> {
  ConfigurationNotifier({required this.configurationRepository});

  final ConfigurationRepository configurationRepository;

  void fetchConfiguration() {
    sendRequest(() async {
      return configurationRepository.getConfiguration();
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
