import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:movie_colony/features/auth/presentation/screens/signup_page.dart';
import 'package:movie_colony/features/homescreen/presentation/screens/homescreen.dart';
import 'package:movie_colony/features/homescreen/presentation/screens/homescreen_tab.dart';
import 'package:movie_colony/features/homescreen/presentation/screens/settings_page.dart';
import 'package:movie_colony/features/notification/presentation/screens/notification_list_screen.dart';
import 'package:movie_colony/features/onboarding/presentation/onboarding.dart';
import 'package:movie_colony/features/single_tv/presentation/screens/single_tv_detail.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page Screen Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/onboarding',
      page: Onboarding,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: '/signup',
      page: SignUpPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: '/',
      page: HomeScreenTab,
      children: [
        AutoRoute(
          name: 'HomeScreenRouter',
          path: '',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: HomeScreen),
            AutoRoute(path: 'trending/tv/:id', page: SingleTvDetail),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          name: 'SearchRouter',
          path: 'search',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: Search),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          name: 'NotificationListRouter',
          path: 'notification-list',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: NotificationListScreen),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          name: 'SettingsRouter',
          path: 'settings',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: SettingsPage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
