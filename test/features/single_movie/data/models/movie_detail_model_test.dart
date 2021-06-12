import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/features/single_movie/data/models/movie_detail_model.dart';
import 'package:movie_colony/features/single_movie/domain/entities/movie_detail.dart';

import '../../../../data/data_reader.dart';
import '../../../../data/single_movie/constants.dart';

void main() {
  Map<String, dynamic> jsonToMap() {
    final String jsonString = dataReader('single_movie/movie_detail.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return jsonMap;
  }

  test(
    'should be a subclass of MovieDetail entity',
    () async {
      // assert
      expect(tMovieDetailModel, isA<MovieDetail>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
      () async {
        // arrange

        // act
        final result = MovieDetailModel.fromJson(jsonToMap());
        // assert
        expect(result, tMovieDetailModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tMovieDetailModel.toJson();
        // assert

        expect(result, jsonToMap());
      },
    );
  });
}
