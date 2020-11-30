import 'package:anime_galaxy/anime_setting/ui/widget/circular_setting/circular_image.dart';
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_theme/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnimeGalaxyAppBar {
  static AppBar getAnimeGalaxyAppBar(
      BuildContext context,
      GlobalKey<ScaffoldState> drawerKey,
      String userName,
      ) {
    final df = new DateFormat('a');
    return AppBar(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? SwapThemeDataService.getDarkBGColor()
          : Colors.white,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => drawerKey.currentState.openDrawer(),
            child: Icon(
              Icons.menu,
            ),
          ),
          //TODO : change this to real image of user
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularImage(
              linkImg:
              'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d',
              width: 40,
              height: 40,
            ),
          ),

          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
//                Text(
//                    df.format(DateTime.now()) == 'ص' ||
//                            df.format(DateTime.now()) == 'am'
//                        ? S.current.GoodMorning
//                        : S.current.GoodEvining,
//                    style: TextStyle(
//                      fontSize: 14,
//                      fontFamily: 'Roboto',
//                    )),
                Text('$userName',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    )
                ),
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        // GestureDetector(
        //     onTap: () {
        //       Navigator.pushNamed(drawerKey.currentContext,
        //           NotificationRoutes.ROUTE_NOTIFICATION_SCREEN);
        //     },
        //     child: Icon(Icons.notifications)),
        // SizedBox(
        //   width: 5,
        // ),
        // GestureDetector(onTap: () {}, child: Icon(Icons.search))
        //Add more icon here
      ],
    );

    /*AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.menu,
        ),
        onPressed: () {
          drawerKey.currentState.openDrawer();
        },
      ),
      title: Text(
        'Swaptime',
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
      centerTitle: true,
      actions: [],
    );*/
  }

  static AppBar getBackEnabledAppBar() {
    return AppBar(
//      title: Text(
//        'Swaptime',
//        style: TextStyle(fontWeight: FontWeight.w300),
//      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        // IconButton(
        //   icon: Icon(Icons.search),
        //   onPressed: () {
        //     // TODO Move to Search Page
        //   },
        // )
      ],
    );
  }
}
