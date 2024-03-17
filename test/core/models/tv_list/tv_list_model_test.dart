import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';

import '../../../data/data_reader.dart';
import '../../../data/tv_list/constants.dart';

void main() {
  Map<String, dynamic> jsonToMap() {
    final String jsonString = dataReader('tv_list/tv.json');
    final Map<String, dynamic> jsonMap =
        json.decode(jsonString) as Map<String, dynamic>;
    return jsonMap;
  }

  test(
    'should be a subclass of TvList entity',
    () async {
      // assert
      expect(tTvList, isA<TvList>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
      () async {
        // arrange

        // act
        final result = TvList.fromJson(jsonToMap());
        // assert
        expect(result, tTvList);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act

        // act
        final result = tTvList.toJson();
        // assert

        expect(result, jsonToMap());
      },
    );
  });
}
