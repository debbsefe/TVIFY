import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/single_movie/data/datasources/movie_detail_remote_data_source.dart';
import 'package:movie_colony/features/single_movie/data/repositories/movie_detail_repository_impl.dart';
import 'package:movie_colony/features/single_movie/domain/entities/movie_detail.dart';

import '../../../../data/single_movie/constants.dart';

class MockMovieDetailRemoteDataSource extends Mock
    implements MovieDetailRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockMovieDetailRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MovieDetailRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockMovieDetailRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MovieDetailRepositoryImpl(
        remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
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

  group('getMovieDetail', () {
    final MovieDetail tMovieDetail = tMovieDetailModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getMovieDetail(tId);
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
          when(mockRemoteDataSource.getRemoteMovieDetail(tId))
              .thenAnswer((_) async => tMovieDetailModel);
          // act
          final result = await repository.getMovieDetail(tId);
          // assert
          verify(mockRemoteDataSource.getRemoteMovieDetail(tId));

          expect(result, equals(Right(tMovieDetail)));
        },
      );

      test(
        '''
should return server failure when the call to remote data source is unsuccessful''',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemoteMovieDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getMovieDetail(tId);
          // assert
          verify(mockRemoteDataSource.getRemoteMovieDetail(tId));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        '''
should return server failure when the isConnected is false''',
        () async {
          // act
          final result = await repository.getMovieDetail(tId);

          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
