import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tvify/providers.dart';

final configProvider = Provider<Config>((ref) {
  return Config(
    ref.watch(firebaseFirestoreProvider),
  );
});

class Config {
  Config(FirebaseFirestore store) : _store = store;

  final FirebaseFirestore _store;

  Future<String> fetchToken(String value) async {
    final snapshot = await _store.collection('token').doc(value).get();
    return snapshot.data()?['key'] as String;
  }
}
