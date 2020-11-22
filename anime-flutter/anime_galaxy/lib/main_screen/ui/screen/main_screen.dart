import 'dart:math';

import 'package:anime_galaxy/module_auth/auth_routes.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_explore/ui/screen/explore_screen/explore_screen.dart';
import 'package:anime_galaxy/module_home/ui/screens/home_screen.dart';
import 'package:anime_galaxy/module_navigation/ui/widget/navigation_drawer/anime_navigation_drawer.dart';
import 'package:anime_galaxy/module_notification/ui/screen/notification_screen/notification_screen.dart';
import 'package:anime_galaxy/module_profile/ui/screen/profile_screen/profile_screen.dart';
import 'package:anime_galaxy/module_settings/ui/ui/settings_page/settings_page.dart';
import 'package:anime_galaxy/utils/app_bar/anime_galaxy_app_bar.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class MainScreen extends StatefulWidget {
  final HomeScreen _homeScreen;
  final NotificationScreen _notificationScreen;
  final SettingsPage _settingsScreen;
  final ExploreScreen _exploreScreen;
  final ProfileScreen _profileScreen;
  final AuthService _authService;

  MainScreen(
      this._notificationScreen,
      this._homeScreen,
      this._settingsScreen,
      this._exploreScreen,
      this._profileScreen,
      this._authService,
      );

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _pageIndex = 0;
  String username;
  bool authorized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getName() async {
    username = await widget._authService.username;
    setState(() {});
  }

  @override


  Widget build(BuildContext context) {

    widget._authService.isLoggedIn.then((value) {
      if (value != true) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AuthRoutes.ROUTE_AUTHORIZE, (route) => false);
      } else {
        authorized = true;
        getName();
      }
    });

    var pages = [
      widget._homeScreen,
      widget._notificationScreen,
      widget._exploreScreen,
      widget._profileScreen,
      widget._settingsScreen,
    ];

    return authorized
        ? Scaffold(
      key: _scaffoldKey,
      appBar:
      AnimeGalaxyAppBar.getAnimeGalaxyAppBar(_scaffoldKey, username),
      drawer: AnimeNavigationDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (newPos) {
          _pageIndex = newPos;
          setState(() {});
        },
        backgroundColor: ProjectColors.ThemeColor,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
//                  label: '',
            title: Text(''),
            backgroundColor: ProjectColors.ThemeColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
//                  label: '',
            title: Text(''),
            backgroundColor: ProjectColors.ThemeColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
//                  label: '',
            title: Text(''),
            backgroundColor: ProjectColors.ThemeColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
//                  label: '',
            title: Text(''),
            backgroundColor: ProjectColors.ThemeColor,
          ),
          BottomNavigationBarItem(
            backgroundColor: ProjectColors.ThemeColor,
            icon: Icon(Icons.settings),
//                  label: '',
            title: Text(''),
          ),
        ],
      ),
      body: pages[_pageIndex],
    )
        : Scaffold();
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }
}
