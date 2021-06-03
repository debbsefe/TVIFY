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

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPref;
  late TrendingLocalDataSourceImpl dataSource;

  setUp(() {
    mockPref = MockSharedPreferences();
    dataSource = TrendingLocalDataSourceImpl(mockPref);
  });
  final tTrendingModel = [
    const TrendingModel(
      id: 1,
      name: 'Romance',
      date: '02/12/12',
      posterImage: 'xhw',
      rating: 12,
      backdropImage: '2',
    ),
    const TrendingModel(
      id: 2,
      name: 'Comedy',
      date: '02/12/12',
      posterImage: 'xhw',
      rating: 12,
      backdropImage: '2',
    ),
    const TrendingModel(
      id: 3,
      name: 'Drama',
      date: '02/12/12',
      posterImage: 'xhw',
      rating: 12,
      backdropImage: '2',
    ),
  ];
  group('GetCachedTrending', () {
    test('Return List<TrendingModel> when cache is available', () async {
      when(mockPref.getString(Strings.cachedCategory))
          .thenReturn(dataReader('Trending_list.json'));

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
        await dataSource.cacheLastTrending(tTrendingModel);
        // assert
        final expectedJsonString = json
            .encode(List<dynamic>.from(tTrendingModel.map((x) => x.toJson())));
        verify(mockPref.setString(
          Strings.cachedTrending,
          expectedJsonString,
        ));
      },
    );
  });
}
