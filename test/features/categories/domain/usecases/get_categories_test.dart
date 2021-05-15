import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';
import 'package:movie_colony/features/categories/domain/repositories/categories_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/features/categories/domain/usecases/get_categories.dart';

class MockCategoriesRepository extends Mock implements CategoriesRepository {}

void main() {
  MockCategoriesRepository mockCategoriesRepository =
      MockCategoriesRepository();
  GetAllCategories usecase = GetAllCategories(mockCategoriesRepository);
  final tCategories = [
    Categories(id: 1, name: 'Romance'),
    Categories(id: 2, name: 'Comedy'),
    Categories(id: 3, name: 'Drama'),
  ];

  test(
    'should get categories from the repository',
    () async {
      // arrange, stub the method
      when(mockCategoriesRepository.getCategories())
          .thenAnswer((_) async => Right(tCategories));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tCategories));
      verify(mockCategoriesRepository.getCategories());
      verifyNoMoreInteractions(mockCategoriesRepository);
    },
  );
}
