import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/features/categories/data/models/categories_model.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';

void main() {
  final tCategoriesModel = CategoriesModel(id: 1, name: 'Test');

  test(
    'should be a subclass of Categories entity',
    () async {
      // assert
      expect(tCategoriesModel, isA<Categories>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
      () async {
        // arrange
        String fixture(String name) =>
            File('test/features/categories/data/models/$name')
                .readAsStringSync();
        final String jsonString = fixture('categories.json');
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        // act
        final result = CategoriesModel.fromJson(jsonMap);
        // assert
        expect(result, tCategoriesModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCategoriesModel.toJson();
        // assert
        final expectedMap = {"id": 1, "name": 'Test'};
        expect(result, expectedMap);
      },
    );
  });
}
