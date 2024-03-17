import 'package:movie_colony/core/notifiers/generic_state_notifier.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/auth/domain/usecases/sign_in_anonymous.dart';

class AnonymousSignInNotifier extends GenericStateNotifier<void> {
  AnonymousSignInNotifier(this.usecase);

  final SignInAnonymous usecase;

  void signInAnonymous() {
    sendRequest(() async {
      return usecase(NoParams());
    });
  }
}
