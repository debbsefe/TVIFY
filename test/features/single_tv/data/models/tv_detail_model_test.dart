import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/features/single_tv/data/models/tv_detail_model.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_detail.dart';

import '../../../../data/data_reader.dart';
import '../../../../data/single_tv/constants.dart';

void main() {
  Map<String, dynamic> jsonToMap() {
    final String jsonString = dataReader('single_tv/tv_detail.json');
    final Map<String, dynamic> jsonMap =
        json.decode(jsonString) as Map<String, dynamic>;
    return jsonMap;
  }

  test(
    'should be a subclass of MovieDetail entity',
    () async {
      // assert
      expect(tTvDetailModel, isA<TvDetail>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
      () async {
        // arrange

        // act
        final result = TvDetailModel.fromJson(jsonToMap());
        // assert
        expect(result, tTvDetailModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tTvDetailModel.toJson();
        // assert

        expect(result, jsonToMap());
      },
    );
  });
}
