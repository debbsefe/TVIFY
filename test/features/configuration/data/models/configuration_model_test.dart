import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/features/configuration/data/models/configuration_model.dart';
import 'package:movie_colony/features/configuration/domain/entities/configuration.dart';

import '../../../../data/configuration/constants.dart';
import '../../../../data/data_reader.dart';

void main() {
  test(
    'should be a subclass of Configuration entity',
    () async {
      // assert
      expect(tConfigurationModel, isA<Configuration>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
      () async {
        // arrange

        final String jsonString =
            dataReader('configuration/configuration.json');
        final Map<String, dynamic> jsonMap =
            json.decode(jsonString) as Map<String, dynamic>;
        // act
        final result = ConfigurationModel.fromJson(jsonMap);
        // assert
        expect(result, tConfigurationModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tConfigurationModel.toJson();
        // assert
        final expectedMap = {
          'images': {
            'base_url': 'http://image.tmdb.org/t/p/',
            'secure_base_url': 'https://image.tmdb.org/t/p/',
            'backdrop_sizes': ['w300'],
            'logo_sizes': ['w45'],
            'poster_sizes': ['w92'],
            'profile_sizes': ['w45'],
            'still_sizes': ['w92'],
          },
          'change_keys': ['adult'],
        };
        expect(result, expectedMap);
      },
    );
  });
}
