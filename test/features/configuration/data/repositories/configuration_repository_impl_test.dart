import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/cache/app_cache.dart';
import 'package:movie_colony/core/error/exception.dart';
import 'package:movie_colony/core/error/failure.dart';
import 'package:movie_colony/core/network/network_info.dart';
import 'package:movie_colony/core/utils/strings.dart';
import 'package:movie_colony/features/configuration/data/datasources/configuration_local_data_source.dart';
import 'package:movie_colony/features/configuration/data/datasources/configuration_remote_data_source.dart';
import 'package:movie_colony/features/configuration/data/repositories/configuration_repository_impl.dart';
import 'package:movie_colony/features/configuration/domain/entities/configuration.dart';

import '../../../../data/configuration/constants.dart';

class MockConfigurationRemoteDataSource extends Mock
    implements ConfigurationRemoteDataSource {}

class MockConfigurationLocalDataSource extends Mock
    implements ConfigurationLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockAppCache extends Mock implements AppCache {}

void main() {
  late MockConfigurationRemoteDataSource mockRemoteDataSource;
  late MockConfigurationLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ConfigurationRepositoryImpl repository;
  late MockAppCache cache;
  final tKey = Strings.cachedConfiguration;

  setUp(() {
    mockRemoteDataSource = MockConfigurationRemoteDataSource();
    mockLocalDataSource = MockConfigurationLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    cache = MockAppCache();
    repository = ConfigurationRepositoryImpl(
        localDataSource: mockLocalDataSource,
        remoteDataSource: mockRemoteDataSource,
        cache: cache,
        networkInfo: mockNetworkInfo,);
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

  group('getConfiguration', () {
    final Configuration tConfiguration = tConfigurationModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repository.getConfiguration();
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
          when(mockRemoteDataSource.getRemoteConfiguration())
              .thenAnswer((_) async => tConfigurationModel);
          // act
          final result = await repository.getConfiguration();
          // assert
          verify(mockRemoteDataSource.getRemoteConfiguration());

          expect(result, equals(Right(tConfiguration)));
        },
      );

      test(
        'should call remote data when hasExpired is true',
        () async {
          // act
          when(cache.isExpired(tKey)).thenReturn(true);

          await repository.getConfiguration();
          verify(mockNetworkInfo.isConnected);

          verify(mockRemoteDataSource.getRemoteConfiguration());
        },
      );

      test(
        'should call local data when hasExpired is false',
        () async {
          when(cache.isExpired(tKey)).thenReturn(false);
          // act
          await repository.getConfiguration();
          // assert
          verify(mockLocalDataSource.getCachedConfiguration());
        },
      );

      test(
        '''
should cache the data locally when the call to remote data source is successful''',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemoteConfiguration())
              .thenAnswer((_) async => tConfigurationModel);
          // act
          await repository.getConfiguration();
          // assert
          verify(mockRemoteDataSource.getRemoteConfiguration());
          verify(
              mockLocalDataSource.cacheLastConfiguration(tConfigurationModel),);
        },
      );

      test(
        '''
should return server failure when the call to remote data source is unsuccessful''',
        () async {
          // arrange
          when(mockRemoteDataSource.getRemoteConfiguration())
              .thenThrow(ServerException());
          // act
          final result = await repository.getConfiguration();
          // assert
          verify(mockRemoteDataSource.getRemoteConfiguration());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(const Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        '''
should return last locally cached data when the cached data is present''',
        () async {
          // arrange
          when(mockLocalDataSource.getCachedConfiguration())
              .thenAnswer((_) async => tConfigurationModel);
          // act
          final result = await repository.getConfiguration();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCachedConfiguration());
          expect(result, equals(Right(tConfiguration)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getCachedConfiguration())
              .thenThrow(CacheException());
          // act
          final result = await repository.getConfiguration();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCachedConfiguration());
          expect(result, equals(const Left(CacheFailure())));
        },
      );
    });
  });
}
