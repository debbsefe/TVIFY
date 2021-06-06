import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/features/trending/data/models/trending_model.dart';
import 'package:movie_colony/features/trending/domain/entities/trending.dart';

import '../../../../data/data_reader.dart';
import '../../../../data/trending/constants.dart';

void main() {
  Map<String, dynamic> jsonToMap() {
    final String jsonString = dataReader('trending/trending.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return jsonMap;
  }

  test(
    'should be a subclass of Trending entity',
    () async {
      // assert
      expect(tTrendingModel, isA<Trending>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
      () async {
        // arrange

        // act
        final result = TrendingModel.fromJson(jsonToMap());
        // assert
        expect(result, tTrendingModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tTrendingModel.toJson();
        // assert

        expect(result, jsonToMap());
      },
    );
  });
}
