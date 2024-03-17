import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/auth/domain/usecases/sign_in_google.dart';

class GoogleSignInNotifier extends GenericStateNotifier<void> {
  GoogleSignInNotifier(this.usecase);

  final SignInGoogle usecase;

  void signInWithGoogle() {
    sendRequest(() async {
      return usecase(NoParams());
    });
  }
}
