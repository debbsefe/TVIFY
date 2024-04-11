import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_colony/app_router.dart';

@RoutePage()
class HomeScreenTab extends StatelessWidget {
  const HomeScreenTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        ExploreRoute(),
        WatchListRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            bottomNavigationBar(
              icon: Icons.home_outlined,
              semanticLabel: 'This is the Home Page',
              label: 'Home',
            ),
            bottomNavigationBar(
              icon: Icons.search,
              semanticLabel: 'This is the Search Page ',
              label: 'Explore',
            ),
            bottomNavigationBar(
              icon: Icons.movie,
              semanticLabel: 'This is the WatchList Page',
              label: 'List',
            ),
            bottomNavigationBar(
              icon: Icons.settings,
              semanticLabel: 'This is the Settings Page',
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem bottomNavigationBar({
    required IconData icon,
    required String semanticLabel,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        semanticLabel: semanticLabel,
      ),
      activeIcon: Icon(
        icon,
        semanticLabel: semanticLabel,
      ),
      label: label,
    );
  }
}

@RoutePage()
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
