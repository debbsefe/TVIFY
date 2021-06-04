import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/core/config.dart';

import 'config_test.mocks.dart';

@GenerateMocks([
  RemoteConfig
], customMocks: [
  MockSpec<RemoteConfig>(as: #MockRemoteConfig2, returnNullOnMissingStub: true),
])
void main() {
  late ConfigImpl configImpl;
  late RemoteConfig remoteConfig;
  setUp(() {
    remoteConfig = MockRemoteConfig();
    configImpl = ConfigImpl(remoteConfig);
  });

  group('fetch string/value from firebase remote config', () {
    test('returns a String when activateFetched is true', () async {
      when(remoteConfig.activateFetched()).thenAnswer((_) async => true);
      when(remoteConfig.getString('yes')).thenReturn('1234');
      when(configImpl.fetchToken('yes')).thenAnswer((_) async => '1234');

      expect(await configImpl.fetchToken('yes'), '1234');
    });

    test('returns a String when activateFetched is false', () async {
      when(remoteConfig.activateFetched()).thenAnswer((_) async => false);
      when(remoteConfig.getString('yes')).thenReturn('1234');
      when(configImpl.fetchToken('yes')).thenAnswer((_) async => '1234');

      expect(await configImpl.fetchToken('yes'), '1234');
    });
  });
}
