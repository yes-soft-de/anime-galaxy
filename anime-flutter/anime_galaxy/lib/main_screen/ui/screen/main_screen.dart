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

  int _pageIndex = 3;
  PageController _pageController;
  String username;

  @override
  void initState() {
    super.initState();
    getName();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void getName() async {
    username = await widget._authService.username;
    if (username == null) {
      username = await widget._authService.userID;
      if (username != null) username = username.substring(0, 6);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    widget._authService.isLoggedIn.then((value) {
      if (value != true) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AuthRoutes.ROUTE_AUTHORIZE, (route) => false);
      }
    });
    return Scaffold(
      key: _scaffoldKey,
      appBar: AnimeGalaxyAppBar.getAnimeGalaxyAppBar(_scaffoldKey, username),
      drawer: AnimeNavigationDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        backgroundColor: ProjectColors.ThemeColor,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: ProjectColors.ThemeColor,
            icon: Icon(Icons.settings),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
            backgroundColor: ProjectColors.ThemeColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: '',
            backgroundColor: ProjectColors.ThemeColor,
          ),
//              BottomNavigationBarItem(icon: Icon(Icons.notifications), title: Container(height: 0.0)),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: '',
            backgroundColor: ProjectColors.ThemeColor,
          ),
        ],
      ),
      body: PageView(
        children: [
          widget._settingsScreen,
          widget._profileScreen,
          widget._exploreScreen,
//          widget._notificationScreen,
          widget._homeScreen,
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
