import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_colony/core/core.dart';
import 'package:movie_colony/core/widgets/snackbars.dart';
import 'package:movie_colony/features/auth/presentation/notifiers/anonymous_sign_in_notifier.dart';
import 'package:movie_colony/features/auth/presentation/notifiers/google_sign_in_notifier.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({
    required this.onResult,
    super.key,
  });
  final ValueSetter<bool> onResult;

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> with CustomSnackbar {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ref
      ..listen(googleSignInNotifierProvider, (previous, next) {
        next.mapOrNull(
          success: (error) {
            widget.onResult(true);
          },
          error: (value) {
            showErrorSnackBar(context, value.error.toString());
            widget.onResult(false);
          },
        );
      })
      ..listen(anonymousSignInNotifierProvider, (previous, next) {
        next.mapOrNull(
          success: (error) {
            widget.onResult(true);
          },
          error: (value) {
            showErrorSnackBar(context, value.error.toString());
            widget.onResult(false);
          },
        );
      });

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Movie',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      'Colony',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              const GoogleSignInButton(),
              TextButton(
                onPressed: () async {
                  await ref
                      .read(anonymousSignInNotifierProvider.notifier)
                      .signInAnonymous();
                },
                child: const Text('Skip to app'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSigningIn =
        ref.watch(googleSignInNotifierProvider) == const LoadingState.loading();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: isSigningIn
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                await ref
                    .read(googleSignInNotifierProvider.notifier)
                    .signInWithGoogle();
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
