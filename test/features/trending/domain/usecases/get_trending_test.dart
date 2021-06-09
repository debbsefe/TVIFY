import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/core/usecases/usecase.dart';

import 'package:mockito/mockito.dart';
import 'package:movie_colony/features/trending/domain/entities/trending.dart';
import 'package:movie_colony/features/trending/domain/repositories/trending_repository.dart';
import 'package:movie_colony/features/trending/domain/usecases/get_trending_weekly.dart';

class MockTrendingRepository extends Mock implements TrendingRepository {}

void main() {
  MockTrendingRepository mockTrendingRepository;
  GetWeeklyTrending usecase;
  final tTrending = [
    const Trending(
      id: 1,
      name: 'Romance',
      date: '02/12/12',
      posterImage: 'xhw',
      rating: 12,
      backdropImage: '2',
      overview: 'test',
    ),
    const Trending(
      id: 1,
      name: 'Romance',
      date: '02/12/12',
      posterImage: 'xhw',
      rating: 12,
      backdropImage: '2',
      overview: 'test',
    ),
  ];

  test(
    'should get Trending from the repository',
    () async {
      mockTrendingRepository = MockTrendingRepository();
      usecase = GetWeeklyTrending(mockTrendingRepository);
      // arrange, stub the method
      when(mockTrendingRepository.getTrendingWeekly())
          .thenAnswer((_) async => Right(tTrending));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tTrending));
      verify(mockTrendingRepository.getTrendingWeekly());
      verifyNoMoreInteractions(mockTrendingRepository);
    },
  );
}
