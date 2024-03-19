import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/features/single_tv/data/repositories/tv_detail_repository.dart';
import 'package:movie_colony/features/single_tv/domain/usecases/get_tv_detail.dart';

import '../../../../data/single_tv/constants.dart';

class MockTvDetailRepository extends Mock implements TvDetailRepository {}

void main() {
  MockTvDetailRepository mockTvDetailRepository;
  GetTvDetail usecase;

  test(
    'should get TvDetail from the repository',
    () async {
      mockTvDetailRepository = MockTvDetailRepository();
      usecase = GetTvDetail(mockTvDetailRepository);
      // arrange, stub the method
      when(mockTvDetailRepository.getTvDetail(tId))
          .thenAnswer((_) async => const Right(tTvDetail));
      // act
      final result = await usecase(const Params(id: tId));
      // assert
      expect(result, const Right(tTvDetail));
      verify(mockTvDetailRepository.getTvDetail(tId));
      verifyNoMoreInteractions(mockTvDetailRepository);
    },
  );
}
