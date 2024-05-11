import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tvfiy/app_router.dart';
import 'package:tvfiy/core/core.dart';

@RoutePage()
class HomeScreenTab extends StatelessWidget {
  const HomeScreenTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        ExploreRoute(),
        NotificationListRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          unselectedItemColor: CustomTheme.grey300,
          selectedItemColor: CustomTheme.primaryColor,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            bottomNavigationBar(
              iconPath: CustomIcons.home,
              semanticLabel: 'This is the Home Page',
              label: 'Home',
            ),
            bottomNavigationBar(
              iconPath: CustomIcons.explore,
              semanticLabel: 'This is the Explore Page ',
              label: 'Explore',
            ),
            bottomNavigationBar(
              iconPath: CustomIcons.watchlist,
              semanticLabel: 'This is the WatchList Page',
              label: 'List',
            ),
            bottomNavigationBar(
              iconPath: CustomIcons.settings,
              semanticLabel: 'This is the Settings Page',
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem bottomNavigationBar({
    required String iconPath,
    required String semanticLabel,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        semanticsLabel: semanticLabel,
      ),
      activeIcon: SvgPicture.asset(
        iconPath,
        semanticsLabel: semanticLabel,
        colorFilter:
            const ColorFilter.mode(CustomTheme.primaryColor, BlendMode.srcIn),
      ),
      label: label,
    );
  }
}
