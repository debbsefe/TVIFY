import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/features/single_tv/data/models/tv_cast_model.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_cast.dart';

import '../../../../data/data_reader.dart';
import '../../../../data/single_tv/constants.dart';

void main() {
  Map<String, dynamic> jsonToMap() {
    final String jsonString = dataReader('single_tv/tv_cast.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return jsonMap;
  }

  test(
    'should be a subclass of MovieCast entity',
    () async {
      // assert
      expect(tTvCastModel, isA<TvCast>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
      () async {
        // arrange

        // act
        final result = TvCastModel.fromJson(jsonToMap());
        // assert
        expect(result, tTvCastModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tTvCastModel.toJson();
        // assert

        expect(result, jsonToMap());
      },
    );
  });
}
