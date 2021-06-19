import 'package:flutter/material.dart';

import 'homescreen.dart';
import 'settings_widget.dart';

// ignore: use_key_in_widget_constructors
class HomeScreenTab extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _HomeScreenTabState();
  }
}

class _HomeScreenTabState extends State<HomeScreenTab> {
  int _currentIndex = 0;
  List<Widget> pageList = <Widget>[];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    pageList
      ..add(const HomeScreen())
      ..add(const Search())
      ..add(const WatchList())
      ..add(const SettingsWidget());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
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
        ));
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
