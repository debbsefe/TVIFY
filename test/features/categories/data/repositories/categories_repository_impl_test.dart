import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/cache/app_cache.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_local_data_source.dart';
import 'package:movie_colony/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:movie_colony/features/categories/data/models/categories_model.dart';
import 'package:movie_colony/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:movie_colony/features/categories/domain/entities/categories.dart';

class MockCategoriesRemoteDataSource extends Mock
    implements CategoriesRemoteDataSource {}

class MockCategoriesLocalDataSource extends Mock
    implements CategoriesLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockAppCache extends Mock implements AppCache {}

void main() {
  late MockCategoriesRemoteDataSource mockRemoteDataSource;
  late MockCategoriesLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late CategoriesRepository repository;
  late MockAppCache cache;
  final tKey = Strings.cachedCategory;

  setUp(() {
    mockRemoteDataSource = MockCategoriesRemoteDataSource();
    mockLocalDataSource = MockCategoriesLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    cache = MockAppCache();
    repository = CategoriesRepository(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      cache: cache,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getCategory', () {
    final List<CategoriesModel> tCategoriesModel = [
      CategoriesModel(id: 1, name: 'Romance'),
      CategoriesModel(id: 2, name: 'Comedy'),
      CategoriesModel(id: 3, name: 'Drama'),
    ];
    final List<Categories> tCategories = tCategoriesModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getCategories();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        '''
should return remote data when the call to remote data source is successful''',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemoteCategories())
              .thenAnswer((_) async => tCategoriesModel);
          // act
          final result = await repository.getCategories();
          // assert
          verify(mockRemoteDataSource.getRemoteCategories());

          expect(result, equals(Right<Failure, List<Categories>>(tCategories)));
        },
      );

      test(
        'should call remote data when hasExpired is true',
        () async {
          // act
          when(cache.isExpired(tKey)).thenReturn(true);

          await repository.getCategories();
          verify(mockNetworkInfo.isConnected);

          verify(mockRemoteDataSource.getRemoteCategories());
        },
      );

      test(
        'should call local data when hasExpired is false',
        () async {
          when(cache.isExpired(tKey)).thenReturn(false);
          // act
          await repository.getCategories();
          // assert
          verify(mockLocalDataSource.getCachedCategory());
        },
      );

      test(
        '''
should cache the data locally when the call to remote data source is successful''',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemoteCategories())
              .thenAnswer((_) async => tCategoriesModel);
          // act
          await repository.getCategories();
          // assert
          verify(mockRemoteDataSource.getRemoteCategories());
          verify(mockLocalDataSource.cacheLastCategory(tCategoriesModel));
        },
      );

      test(
        '''
should return server failure when the call to remote data source is unsuccessful''',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemoteCategories())
              .thenThrow(ServerException());
          // act
          final result = await repository.getCategories();
          // assert
          verify(mockRemoteDataSource.getRemoteCategories());
          verifyZeroInteractions(mockLocalDataSource);
          expect(
            result,
            equals(const Left<Failure, List<Categories>>(ServerFailure())),
          );
        },
      );
    });

    runTestsOffline(() {
      test(
        '''
should return last locally cached data when the cached data is present''',
        () async {
          // arrange
          when(mockLocalDataSource.getCachedCategory())
              .thenAnswer((_) async => tCategoriesModel);
          // act
          final result = await repository.getCategories();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCachedCategory());
          expect(result, equals(Right<Failure, List<Categories>>(tCategories)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getCachedCategory())
              .thenThrow(CacheException());
          // act
          final result = await repository.getCategories();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCachedCategory());
          expect(
            result,
            equals(const Left<Failure, List<Categories>>(CacheFailure())),
          );
        },
      );
    });
  });
}
