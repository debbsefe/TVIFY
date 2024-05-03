import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_colony/core/repository.dart/shared_preferences_repository.dart';
import 'package:movie_colony/features/auth/presentation/screens/signup_page.dart';
import 'package:movie_colony/features/explore/presentation/screens/explore_page.dart';
import 'package:movie_colony/features/homescreen/presentation/screens/homescreen.dart';
import 'package:movie_colony/features/homescreen/presentation/screens/homescreen_tab.dart';
import 'package:movie_colony/features/homescreen/presentation/screens/settings_page.dart';
import 'package:movie_colony/features/notification/presentation/screens/notification_list_screen.dart';
import 'package:movie_colony/features/onboarding/presentation/onboarding.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/single_tv_detail_page.dart';
import 'package:movie_colony/providers.dart';

part 'app_router.gr.dart';

final appRouterProvider =
    Provider.family<AppRouter, WidgetRef>((ref, widgetRef) {
  final user = ref.watch(userChangesProvider).value;
  final isFirstTimeUser =
      ref.watch(sharedPreferencesRepositoryProvider).getFirstTimeUser();
  final guard = AuthGuard(
    ref: widgetRef,
    user: user,
    isFirstTimeUser: isFirstTimeUser,
  );
  return AppRouter(guards: [guard]);
});

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter({required this.guards, super.navigatorKey});

  final List<AutoRouteGuard> guards;
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(
          initial: true,
          page: HomeRouteTab.page,
          guards: guards,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: ExploreRoute.page),
            AutoRoute(page: WatchListRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
        AutoRoute(page: SingleTvDetailRoute.page, guards: guards),
      ];
}

class AuthGuard extends AutoRouteGuard {
  AuthGuard({
    required this.ref,
    required this.user,
    required this.isFirstTimeUser,
  });
  final WidgetRef ref;
  final User? user;
  final bool isFirstTimeUser;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (isFirstTimeUser) {
      resolver.redirect(const OnboardingRoute());
    } else if (user != null) {
      resolver.next();
    } else {
      resolver.redirect(
        SignUpRoute(
          onResult: (bool value) {
            if (value) {
              resolver.next();
            }
          },
        ),
      );
    }
  }
}
