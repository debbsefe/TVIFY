import 'package:movie_colony/features/configuration/data/models/configuration_model.dart';

final tConfigurationModel = ConfigurationModel(
  images: ImageModel(
      baseUrl: 'http://image.tmdb.org/t/p/',
      secureBaseUrl: 'https://image.tmdb.org/t/p/',
      backdropSizes: ['w300'],
      logoSizes: ['w45'],
      posterSizes: ['w92'],
      profileSizes: ['w45'],
      stillSizes: ['w92'],),
  changeKeys: const ['adult'],
);
