import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app_router.gr.dart';

// ignore: use_key_in_widget_constructors
class HomeScreenTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
        routes: const [
          HomeScreenRouter(),
          SearchRouter(),
          WatchListRouter(),
          SettingsRouter(),
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
                label: 'Search',
              ),
              bottomNavigationBar(
                icon: Icons.movie,
                semanticLabel: 'This is the WatchList Page',
                label: 'WatchList',
              ),
              bottomNavigationBar(
                icon: Icons.settings,
                semanticLabel: 'This is the Settings Page',
                label: 'Settings',
              ),
            ],
          );
        });
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

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class WatchList extends StatelessWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
