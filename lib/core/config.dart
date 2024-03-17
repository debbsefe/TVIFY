import 'package:cloud_firestore/cloud_firestore.dart';

class Config {
  Config(this.store);

  ///fetch token from store
  final FirebaseFirestore store;
  String? _token;
  String? get token => _token;

  Future<String> fetchToken(String value) async {
    if (token == null) {
      final snapshot = await store.collection('token').doc(value).get();
      _token = snapshot.data()?['key'] as String;
      return snapshot.data()?['key'] as String;
    }

    return token!;
  }
}
