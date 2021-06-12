import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:movie_colony/features/single_tv/domain/repositories/similar_tv_repository.dart';
import 'package:movie_colony/features/single_tv/domain/usecases/get_similar_tv.dart';

import '../../../../data/single_tv/constants.dart';
import '../../../../data/tv_list/constants.dart';

class MockSimilarTvRepository extends Mock implements SimilarTvRepository {}

void main() {
  MockSimilarTvRepository mockSimilarTvRepository;
  GetSimilarTv usecase;

  test(
    'should get SimilarTv from the repository',
    () async {
      mockSimilarTvRepository = MockSimilarTvRepository();
      usecase = GetSimilarTv(mockSimilarTvRepository);
      // arrange, stub the method
      when(mockSimilarTvRepository.getSimilarTv(tId))
          .thenAnswer((_) async => const Right(tTvListModel));
      // act
      final result = await usecase(const Params(id: tId));
      // assert
      expect(result, const Right(tTvListModel));
      verify(mockSimilarTvRepository.getSimilarTv(tId));
      verifyNoMoreInteractions(mockSimilarTvRepository);
    },
  );
}
