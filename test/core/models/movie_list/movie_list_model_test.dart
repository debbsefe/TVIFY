import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/core/models/movie_list/movie_list.dart';
import 'package:movie_colony/core/models/movie_list/movie_list_model.dart';
import '../../../data/data_reader.dart';
import '../../../data/movie_list/constants.dart';

void main() {
  Map<String, dynamic> jsonToMap() {
    final String jsonString = dataReader('movie_list/movie.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return jsonMap;
  }

  test(
    'should be a subclass of MovieList entity',
    () async {
      // assert
      expect(tMovieList, isA<MovieList>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
      () async {
        // arrange

        // act
        final result = MovieListModel.fromJson(jsonToMap());
        // assert
        expect(result, tMovieList);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act

        // act
        final result = tMovieList.toJson();
        // assert

        expect(result, jsonToMap());
      },
    );
  });
}
