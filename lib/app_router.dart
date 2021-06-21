import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import 'features/homescreen/presentation/screens/homescreen.dart';
import 'features/homescreen/presentation/screens/homescreen_tab.dart';
import 'features/homescreen/presentation/screens/settings_page.dart';
import 'features/onboarding/presentation/onboarding.dart';
import 'features/single_tv/presentation/screens/single_tv_detail.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      path: '/onboarding',
      page: Onboarding,
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
          name: 'WatchListRouter',
          path: 'watchlist',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: WatchList),
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
