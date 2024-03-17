import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_colony/features/auth/presentation/screens/signup_page.dart';
import 'package:movie_colony/features/homescreen/presentation/screens/homescreen.dart';
import 'package:movie_colony/features/homescreen/presentation/screens/homescreen_tab.dart';
import 'package:movie_colony/features/homescreen/presentation/screens/settings_page.dart';
import 'package:movie_colony/features/notification/presentation/screens/notification_list_screen.dart';
import 'package:movie_colony/features/onboarding/presentation/onboarding.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/single_tv_detail.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(
          page: HomeRouteTab.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: SearchRoute.page),
            AutoRoute(page: NotificationListRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
        AutoRoute(page: SingleTvDetailRoute.page),
      ];
}
