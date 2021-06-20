// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i8;
import 'package:flutter/material.dart' as _i2;
import 'package:movie_colony/features/homescreen/presentation/screens/homescreen.dart'
    as _i5;
import 'package:movie_colony/features/homescreen/presentation/screens/homescreen_tab.dart'
    as _i4;
import 'package:movie_colony/features/homescreen/presentation/screens/settings_page.dart'
    as _i7;
import 'package:movie_colony/features/onboarding/presentation/onboarding.dart'
    as _i3;
import 'package:movie_colony/features/single_tv/presentation/screens/single_tv_detail.dart'
    as _i6;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    OnboardingRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.Onboarding();
        }),
    HomeScreenTabRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.HomeScreenTab();
        }),
    HomeScreenRouter.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    SearchRouter.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    WatchListRouter.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    SettingsRouter.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i1.EmptyRouterPage();
        }),
    HomeScreenRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.HomeScreen();
        }),
    SingleTvDetailRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<SingleTvDetailRouteArgs>(
              orElse: () =>
                  SingleTvDetailRouteArgs(id: pathParams.getString('id')));
          return _i6.SingleTvDetail(key: args.key, id: args.id);
        }),
    SearchRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.Search();
        }),
    WatchListRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.WatchList();
        }),
    SettingsPageRoute.name: (routeData) => _i1.AdaptivePage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i7.SettingsPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(OnboardingRoute.name, path: '/onboarding', children: [
          _i1.RouteConfig('*#redirect',
              path: '*', redirectTo: '', fullMatch: true)
        ]),
        _i1.RouteConfig(HomeScreenTabRoute.name, path: '/', children: [
          _i1.RouteConfig(HomeScreenRouter.name, path: 'home', children: [
            _i1.RouteConfig(HomeScreenRoute.name, path: ''),
            _i1.RouteConfig(SingleTvDetailRoute.name, path: 'tv:id'),
            _i1.RouteConfig('*#redirect',
                path: '*', redirectTo: '', fullMatch: true)
          ]),
          _i1.RouteConfig(SearchRouter.name, path: 'search', children: [
            _i1.RouteConfig(SearchRoute.name, path: ''),
            _i1.RouteConfig('*#redirect',
                path: '*', redirectTo: '', fullMatch: true)
          ]),
          _i1.RouteConfig(WatchListRouter.name, path: 'watchlist', children: [
            _i1.RouteConfig(WatchListRoute.name, path: ''),
            _i1.RouteConfig('*#redirect',
                path: '*', redirectTo: '', fullMatch: true)
          ]),
          _i1.RouteConfig(SettingsRouter.name, path: 'settings', children: [
            _i1.RouteConfig(SettingsPageRoute.name, path: ''),
            _i1.RouteConfig('*#redirect',
                path: '*', redirectTo: '', fullMatch: true)
          ])
        ])
      ];
}

class OnboardingRoute extends _i1.PageRouteInfo {
  const OnboardingRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/onboarding', initialChildren: children);

  static const String name = 'OnboardingRoute';
}

class HomeScreenTabRoute extends _i1.PageRouteInfo {
  const HomeScreenTabRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'HomeScreenTabRoute';
}

class HomeScreenRouter extends _i1.PageRouteInfo {
  const HomeScreenRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'home', initialChildren: children);

  static const String name = 'HomeScreenRouter';
}

class SearchRouter extends _i1.PageRouteInfo {
  const SearchRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'search', initialChildren: children);

  static const String name = 'SearchRouter';
}

class WatchListRouter extends _i1.PageRouteInfo {
  const WatchListRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'watchlist', initialChildren: children);

  static const String name = 'WatchListRouter';
}

class SettingsRouter extends _i1.PageRouteInfo {
  const SettingsRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'settings', initialChildren: children);

  static const String name = 'SettingsRouter';
}

class HomeScreenRoute extends _i1.PageRouteInfo {
  const HomeScreenRoute() : super(name, path: '');

  static const String name = 'HomeScreenRoute';
}

class SingleTvDetailRoute extends _i1.PageRouteInfo<SingleTvDetailRouteArgs> {
  SingleTvDetailRoute({_i8.Key? key, required String id})
      : super(name,
            path: 'tv:id',
            args: SingleTvDetailRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'SingleTvDetailRoute';
}

class SingleTvDetailRouteArgs {
  const SingleTvDetailRouteArgs({this.key, required this.id});

  final _i8.Key? key;

  final String id;
}

class SearchRoute extends _i1.PageRouteInfo {
  const SearchRoute() : super(name, path: '');

  static const String name = 'SearchRoute';
}

class WatchListRoute extends _i1.PageRouteInfo {
  const WatchListRoute() : super(name, path: '');

  static const String name = 'WatchListRoute';
}

class SettingsPageRoute extends _i1.PageRouteInfo {
  const SettingsPageRoute() : super(name, path: '');

  static const String name = 'SettingsPageRoute';
}
