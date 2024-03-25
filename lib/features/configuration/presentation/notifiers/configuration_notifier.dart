import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/notifiers/generic_state.dart';
import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/features/configuration/data/repositories/configuration_repository.dart';

final configurationNotifierProvider = StateNotifierProvider<
    ConfigurationNotifier, GenericState<ConfigurationModel?>>((ref) {
  return ConfigurationNotifier(
    configurationRepository: ref.watch(configurationRepositoryProvider),
  );
});

class ConfigurationNotifier extends GenericStateNotifier<ConfigurationModel?> {
  ConfigurationNotifier({required this.configurationRepository});

  final ConfigurationRepository configurationRepository;

  void fetchConfiguration() {
    sendRequest(() async {
      return configurationRepository.getConfiguration();
    });
  }

  GenericState<ConfigurationModel?> currentState() {
    return state;
  }

  String fetchPosterSizeUrl() {
    final current = currentState();
    if (current is Loaded<ConfigurationModel>) {
      return '${current.value!.images?.secureBaseUrl}${current.value!.images?.posterSizes![4]}/';
    } else {
      return 'https://image.tmdb.org/t/p/w500/';
    }
  }

  String fetchProfileSizeUrl() {
    final current = currentState();
    if (current is Loaded<ConfigurationModel>) {
      return '${current.value!.images?.secureBaseUrl}${current.value!.images!.profileSizes![3]}/';
    } else {
      return 'https://image.tmdb.org/t/p/original/';
    }
  }
}
