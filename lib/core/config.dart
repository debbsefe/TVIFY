import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class Config {
  Future<String> fetchToken(String value);
}

class ConfigImpl implements Config {
  ///fetch token from remote config
  final RemoteConfig remoteConfig;

  ConfigImpl(this.remoteConfig);
  @override
  Future<String> fetchToken(String value) async {
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
    return remoteConfig.getString(value);
  }
}
