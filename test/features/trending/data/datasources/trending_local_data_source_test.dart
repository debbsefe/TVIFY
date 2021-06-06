import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_local_data_source.dart';
import 'package:movie_colony/features/trending/data/models/trending_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/data_reader.dart';
import '../../../../data/trending/constants.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPref;
  late TrendingLocalDataSourceImpl dataSource;

  setUp(() {
    mockPref = MockSharedPreferences();
    dataSource = TrendingLocalDataSourceImpl(mockPref);
  });

  group('GetCachedTrending', () {
    test('Return List<TrendingModel> when cache is available', () async {
      when(mockPref.getString(Strings.cachedTrending))
          .thenReturn(dataReader('trending/trending_list.json'));

      expect(await dataSource.getCachedTrending(), isA<List<TrendingModel>>());
    });

    test('Return cacheException when no cache is available', () async {
      when(mockPref.getString(Strings.cachedTrending)).thenReturn(null);

      expect(() => dataSource.getCachedTrending(),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheLastTrending', () {
    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        await dataSource.cacheLastTrending(tTrendingModelList);
        // assert
        final expectedJsonString = json.encode(
            List<dynamic>.from(tTrendingModelList.map((x) => x.toJson())));
        verify(mockPref.setString(
          Strings.cachedTrending,
          expectedJsonString,
        ));
      },
    );
  });
}
