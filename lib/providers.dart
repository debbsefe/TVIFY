import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final httpClientProvider = Provider<Client>((ref) => Client());

final userChangesProvider = StreamProvider<User?>(
  (ref) => ref.watch(firebaseAuthProvider).userChanges(),
);

final googleSignInProvider = Provider<GoogleSignIn>(
  (ref) => GoogleSignIn(),
);

final googleAuthProvider = Provider<GoogleAuthProvider>(
  (ref) => GoogleAuthProvider(),
);
