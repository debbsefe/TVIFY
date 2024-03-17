import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/models/tv_list/tv_list.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/single_tv/data/datasources/similar_tv_remote_data_source.dart';
import 'package:movie_colony/features/single_tv/data/repositories/similar_tv_repository_impl.dart';

import '../../../../data/single_tv/constants.dart';
import '../../../../data/tv_list/constants.dart';

class MockSimilarTvRemoteDataSource extends Mock
    implements SimilarTvRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockSimilarTvRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late SimilarTvRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockSimilarTvRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SimilarTvRepositoryImpl(
        remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo,);
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

  group('getSimilarTv', () {
    const List<TvList> tSimilarTv = tTvListModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getSimilarTv(tId);
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
          when(mockRemoteDataSource.getRemoteSimilarTv(tId))
              .thenAnswer((_) async => tTvListModel);
          // act
          final result = await repository.getSimilarTv(tId);
          // assert
          verify(mockRemoteDataSource.getRemoteSimilarTv(tId));

          expect(result, equals(const Right(tSimilarTv)));
        },
      );

      test(
        '''
should return server failure when the call to remote data source is unsuccessful''',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemoteSimilarTv(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getSimilarTv(tId);
          // assert
          verify(mockRemoteDataSource.getRemoteSimilarTv(tId));
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
          final result = await repository.getSimilarTv(tId);

          expect(result, equals(const Left(ServerFailure())));
        },
      );
    });
  });
}
