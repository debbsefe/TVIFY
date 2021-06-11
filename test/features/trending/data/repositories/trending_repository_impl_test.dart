import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/models/movie_list/movie_list.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_local_data_source.dart';
import 'package:movie_colony/features/trending/data/datasources/trending_remote_data_source.dart';
import 'package:movie_colony/features/trending/data/repositories/trending_repository_impl.dart';

import '../../../../data/movie_list/constants.dart';

class MockTrendingRemoteDataSource extends Mock
    implements TrendingRemoteDataSource {}

class MockTrendingLocalDataSource extends Mock
    implements TrendingLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockTrendingRemoteDataSource mockRemoteDataSource;
  late MockTrendingLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late TrendingRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockTrendingRemoteDataSource();
    mockLocalDataSource = MockTrendingLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TrendingRepositoryImpl(
        localDataSource: mockLocalDataSource,
        remoteDataSource: mockRemoteDataSource,
        networkInfo: mockNetworkInfo);
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

  group('getTrendingWeekly', () {
    final List<MovieList> tTrending = tMovieListModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getTrendingWeekly();
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
          when(mockRemoteDataSource.getRemoteTrendingWeekly())
              .thenAnswer((_) async => tMovieListModel);
          // act
          final result = await repository.getTrendingWeekly();
          // assert
          verify(mockRemoteDataSource.getRemoteTrendingWeekly());

          expect(result, equals(Right(tTrending)));
        },
      );

      test(
        '''
should cache the data locally when the call to remote data source is successful''',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemoteTrendingWeekly())
              .thenAnswer((_) async => tMovieListModel);
          // act
          await repository.getTrendingWeekly();
          // assert
          verify(mockRemoteDataSource.getRemoteTrendingWeekly());
          verify(mockLocalDataSource.cacheLastTrendingWeekly(tMovieListModel));
        },
      );

      test(
        '''
should return server failure when the call to remote data source is unsuccessful''',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemoteTrendingWeekly())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTrendingWeekly();
          // assert
          verify(mockRemoteDataSource.getRemoteTrendingWeekly());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        '''
should return last locally cached data when the cached data is present''',
        () async {
          // arrange
          when(mockLocalDataSource.getCachedTrendingWeekly())
              .thenAnswer((_) async => tMovieListModel);
          // act
          final result = await repository.getTrendingWeekly();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCachedTrendingWeekly());
          expect(result, equals(Right(tTrending)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getCachedTrendingWeekly())
              .thenThrow(CacheException());
          // act
          final result = await repository.getTrendingWeekly();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCachedTrendingWeekly());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
