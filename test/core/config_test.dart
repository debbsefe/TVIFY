import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_colony/core/config.dart';

class MockRemoteConfig extends Mock implements RemoteConfig {}

void main() {
  late ConfigImpl configImpl;
  late RemoteConfig remoteConfig;
  setUp(() {
    remoteConfig = MockRemoteConfig();
    configImpl = ConfigImpl(remoteConfig);
  });

  group('fetch string/value from firebase remote config', () {
    test('returns a String when activate is true', () async {
      when(remoteConfig.activate()).thenAnswer((_) async => true);
      when(remoteConfig.getString('yes')).thenReturn('1234');
      when(configImpl.fetchToken('yes')).thenAnswer((_) async => '1234');

      expect(await configImpl.fetchToken('yes'), '1234');
    });

    test('returns a String when activate is false', () async {
      when(remoteConfig.activate()).thenAnswer((_) async => false);
      when(remoteConfig.getString('yes')).thenReturn('1234');
      when(configImpl.fetchToken('yes')).thenAnswer((_) async => '1234');

      expect(await configImpl.fetchToken('yes'), '1234');
    });
  });
}
