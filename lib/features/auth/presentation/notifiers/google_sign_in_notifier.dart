import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_colony/features/auth/domain/usecases/sign_in_google.dart';

import '../../../../core/notifiers/generic_state_notifier.dart';
import '../../../../core/usecases/usecase.dart';

class GoogleSignInNotifier extends GenericStateNotifier<User?> {
  GoogleSignInNotifier(this.usecase);

  final SignInGoogle usecase;

  void signInWithGoogle() {
    sendRequest(() async {
      return await usecase(NoParams());
    });
  }
}
