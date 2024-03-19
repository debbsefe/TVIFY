import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/single_tv/data/datasources/tv_detail_remote_data_source.dart';
import 'package:movie_colony/features/single_tv/data/repositories/tv_detail_repository.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_detail.dart';

import '../../../../data/single_tv/constants.dart';

class MockTvDetailRemoteDataSource extends Mock
    implements TvDetailRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockTvDetailRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late TvDetailRepository repository;

  setUp(() {
    mockRemoteDataSource = MockTvDetailRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvDetailRepository(
      remoteDataSource: mockRemoteDataSource,
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

  group('getTvDetail', () {
    final TvDetail tTvDetail = tTvDetailModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getTvDetail(tId);
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
          when(mockRemoteDataSource.getRemoteTvDetail(tId))
              .thenAnswer((_) async => tTvDetailModel);
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockRemoteDataSource.getRemoteTvDetail(tId));

          expect(result, equals(Right(tTvDetail)));
        },
      );

      test(
        '''
should return server failure when the call to remote data source is unsuccessful''',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemoteTvDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockRemoteDataSource.getRemoteTvDetail(tId));
          expect(result, equals(const Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        '''
should return server failure when the isConnected is false''',
        () async {
          // act
          final result = await repository.getTvDetail(tId);

          expect(result, equals(const Left(ServerFailure())));
        },
      );
    });
  });
}
