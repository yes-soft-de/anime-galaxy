import 'package:anime_galaxy/module_home/ui/screens/home_screen.dart';
import 'package:anime_galaxy/module_notification/ui/screen/notification_screen/notification_screen.dart';
import 'package:anime_galaxy/module_settings/ui/ui/settings_page/settings_page.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class MainScreen extends StatefulWidget {
  final HomeScreen _homeScreen;
  final NotificationScreen _notificationScreen;
  final SettingsPage _settingsScreen;
//  final ExploreScreen _exploreScreen;

  MainScreen(
      this._notificationScreen,
      this._homeScreen,
      this._settingsScreen,
//      this._exploreScreen,
      );

  @override
  _MainScreenState createState() => _MainScreenState( );
}

class _MainScreenState extends State<MainScreen> {

  int _pageIndex = 0;
  PageController _pageController;



  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //TODO : replace the appbar with the proper one
      appBar : AppBar(title: Text('Anime'),),
      bottomNavigationBar: SizedBox(
        height: 40,
        child: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: onTabTapped,
          backgroundColor: ProjectColors.ThemeColor,
          fixedColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem( icon: Icon(Icons.dashboard),title: Container(height: 0.0)),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), title: Container(height: 0.0)),
//            BottomNavigationBarItem(icon: Icon(Icons.explore), title: Container(height: 0.0)),
            BottomNavigationBarItem(icon: Icon(Icons.settings), title: Container(height: 0.0)),
          ],

        ),
      ),
      body: PageView(
        children: [
          widget._homeScreen,
          widget._notificationScreen,
//          widget._exploreScreen,
          widget._settingsScreen,

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
    this._pageController.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
  }
}
