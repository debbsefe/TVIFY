import 'package:tvify/core/core.dart';
import 'package:tvify/features/configuration/data/repositories/configuration_repository.dart';

final configurationNotifierProvider =
    StateNotifierProvider<ConfigurationNotifier, LoadingState>((ref) {
  return ConfigurationNotifier(
    configurationRepository: ref.watch(configurationRepositoryProvider),
  )..init();
});

class ConfigurationNotifier extends StateNotifier<LoadingState> {
  ConfigurationNotifier({required this.configurationRepository})
      : super(const LoadingState.idle());

  final ConfigurationRepository configurationRepository;
  final logger = Logger('ConfigurationNotifier');

  Future<void> init() async {
    try {
      state = const LoadingState.loading();
      final result = await configurationRepository.getConfiguration();
      state = LoadingState.success(result);
    } catch (e) {
      state = LoadingState.error(e);
      logger.fine(e.toString());
    }
  }

  String fetchPosterSizeUrl() {
    return state.maybeMap(
      success: (success) {
        final value = success.obj! as ConfigurationModel;
        return '${value.images?.secureBaseUrl}${value.images?.posterSizes![4]}/';
      },
      orElse: () => 'https://image.tmdb.org/t/p/w500/',
    );
  }

  String fetchProfileSizeUrl() {
    return state.maybeMap(
      success: (success) {
        final value = success.obj! as ConfigurationModel;
        return '${value.images?.secureBaseUrl}${value.images?.profileSizes![3]}/';
      },
      orElse: () => 'https://image.tmdb.org/t/p/original/',
    );
  }
}
