import 'package:cloud_firestore/cloud_firestore.dart';

class Config {
  Config(this.store);

  ///fetch token from store
  final FirebaseFirestore store;
  String? _token;
  String? get token => _token;

  Future<String> fetchToken(String value) async {
    if (token == null) {
      final DocumentSnapshot snapshot =
          await store.collection('token').doc(value).get();
      final Map<String, dynamic> snap = snapshot.data()! as Map<String, String>;
      _token = snap['key'] as String;
      return snap['key'] as String;
    }

    return token!;
  }
}
