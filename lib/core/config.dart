import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class Config {
  Future<String> fetchToken(String value);
}

class ConfigImpl implements Config {
  ConfigImpl(this.remoteConfig);

  ///fetch token from remote config
  final RemoteConfig remoteConfig;

  @override
  Future<String> fetchToken(String value) async {
    await remoteConfig.fetch();

    await remoteConfig.activate();

    return remoteConfig.getString(value);
  }
}
