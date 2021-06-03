import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/features/trending/data/models/trending_model.dart';
import 'package:movie_colony/features/trending/domain/entities/trending.dart';

import '../../../../data/data_reader.dart';

void main() {
  const tTrendingModel = TrendingModel(
    id: 1,
    name: 'Romance',
    date: '02/12/12',
    posterImage: 'xhw',
    rating: 12,
    backdropImage: '2',
  );

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

        final String jsonString = dataReader('trending.json');
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        // act
        final result = TrendingModel.fromJson(jsonMap);
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
        final expectedMap = {
          'id': 1,
          'name': 'Test',
        };
        expect(result, expectedMap);
      },
    );
  });
}
