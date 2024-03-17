import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/features/single_tv/data/datasources/tv_cast_remote_data_source.dart';
import 'package:movie_colony/features/single_tv/data/models/tv_cast_model.dart';
import 'package:movie_colony/features/single_tv/data/repositories/tv_cast_repository_impl.dart';
import 'package:movie_colony/features/single_tv/domain/entities/tv_cast.dart';

import '../../../../data/single_tv/constants.dart';

class MockTvCastRemoteDataSource extends Mock
    implements TvCastRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockTvCastRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late TvCastRepository repository;

  setUp(() {
    mockRemoteDataSource = MockTvCastRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvCastRepository(
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

  group('getTvCast', () {
    const tTvCastMod = [
      TvCastModel(
        id: 1,
        name: 'Loki',
        knownFor: 'Acting',
        profileImage: 'test',
      ),
    ];
    const List<TvCast> tTvCast = tTvCastMod;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getTvCast(tId);
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
          when(mockRemoteDataSource.getRemoteTvCast(tId))
              .thenAnswer((_) async => tTvCastMod);
          // act
          final result = await repository.getTvCast(tId);
          // assert
          verify(mockRemoteDataSource.getRemoteTvCast(tId));

          expect(result, equals(const Right(tTvCast)));
        },
      );

      test(
        '''
should return server failure when the call to remote data source is unsuccessful''',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemoteTvCast(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvCast(tId);
          // assert
          verify(mockRemoteDataSource.getRemoteTvCast(tId));
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
          final result = await repository.getTvCast(tId);

          expect(result, equals(const Left(ServerFailure())));
        },
      );
    });
  });
}
