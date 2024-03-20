import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityResultProvider = StreamProvider<ConnectivityResult>((ref) {
  final connectivity = Connectivity();
  return connectivity.onConnectivityChanged;
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  final connectivityResult = ref.watch(connectivityResultProvider).value;
  return NetworkInfo(connectivityResult: connectivityResult);
});

class NetworkInfo {
  NetworkInfo({required this.connectivityResult});

  final ConnectivityResult? connectivityResult;
  bool get isConnected => check();
  bool check() {
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
