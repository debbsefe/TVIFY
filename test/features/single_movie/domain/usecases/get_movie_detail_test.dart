import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:movie_colony/features/single_movie/domain/repositories/movie_detail_repository.dart';
import 'package:movie_colony/features/single_movie/domain/usecases/get_movie_detail.dart';

import '../../../../data/single_movie/constants.dart';

class MockMovieDetailRepository extends Mock implements MovieDetailRepository {}

void main() {
  MockMovieDetailRepository mockMovieDetailRepository;
  GetMovieDetail usecase;

  test(
    'should get MovieDetail from the repository',
    () async {
      mockMovieDetailRepository = MockMovieDetailRepository();
      usecase = GetMovieDetail(mockMovieDetailRepository);
      // arrange, stub the method
      when(mockMovieDetailRepository.getMovieDetail(tId))
          .thenAnswer((_) async => const Right(tMovieDetail));
      // act
      final result = await usecase(const Params(id: tId));
      // assert
      expect(result, const Right(tMovieDetail));
      verify(mockMovieDetailRepository.getMovieDetail(tId));
      verifyNoMoreInteractions(mockMovieDetailRepository);
    },
  );
}
