import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/features/single_tv/data/repositories/tv_cast_repository_impl.dart';
import 'package:movie_colony/features/single_tv/domain/usecases/get_tv_cast.dart';

import '../../../../data/single_tv/constants.dart';

class MockTvCastRepository extends Mock implements TvCastRepository {}

void main() {
  MockTvCastRepository mockTvCastRepository;
  GetTvCast usecase;

  test(
    'should get TvCast from the repository',
    () async {
      mockTvCastRepository = MockTvCastRepository();
      usecase = GetTvCast(mockTvCastRepository);
      // arrange, stub the method
      when(mockTvCastRepository.getTvCast(tId))
          .thenAnswer((_) async => const Right(tTvCast));
      // act
      final result = await usecase(const Params(id: tId));
      // assert
      expect(result, const Right(tTvCast));
      verify(mockTvCastRepository.getTvCast(tId));
      verifyNoMoreInteractions(mockTvCastRepository);
    },
  );
}
