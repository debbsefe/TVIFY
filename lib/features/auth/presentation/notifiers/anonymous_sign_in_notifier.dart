import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_colony/features/auth/domain/usecases/sign_in_anonymous.dart';

import '../../../../core/notifiers/generic_state_notifier.dart';
import '../../../../core/usecases/usecase.dart';

class AnonymousSignInNotifier extends GenericStateNotifier<User?> {
  AnonymousSignInNotifier(this.usecase);

  final SignInAnonymous usecase;

  void signInAnonymous() {
    sendRequest(() async {
      return await usecase(NoParams());
    });
  }
}
