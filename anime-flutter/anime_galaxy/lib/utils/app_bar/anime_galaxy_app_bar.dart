import 'package:anime_galaxy/anime_setting/ui/widget/circular_setting/circular_image.dart';
import 'package:anime_galaxy/module_search/search_routes.dart';
import 'package:flutter/material.dart';

class AnimeGalaxyAppBar {
  static AppBar getAnimeGalaxyAppBar(
      BuildContext context,
      GlobalKey<ScaffoldState> drawerKey,
      String userName,
      String userImage,
      ) {
    return AppBar(
      backgroundColor:      Theme.of(context).brightness == Brightness.dark
          ? Colors.white30
          : Colors.grey[300],
      elevation: 1,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularImage(
              linkImg:
              userImage??'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d',
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
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(drawerKey.currentContext,
                  SearchRoutes.ROUTE_Search
              );
            },
            child: Icon(
              Icons.search,
              size: 35,
            )),
        SizedBox(
          width: 10,
        ),
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
  static AppBar getAnimeGalaxyAppBar2(
      BuildContext context,
      GlobalKey<ScaffoldState> drawerKey,
      String userName,
      String userImage,
      ) {
    return AppBar(
      backgroundColor:      Theme.of(context).brightness == Brightness.dark
          ? Colors.white30
          : Colors.grey[300],
      elevation: 1,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularImage(
              linkImg:
              userImage??'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d',
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
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(drawerKey.currentContext,
                  SearchRoutes.ROUTE_Search
              );
            },
            child: Icon(
              Icons.search,
              size: 35,
            )),
        SizedBox(
          width: 10,
        ),
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

  static AppBar getBackEnabledAppBar(  ) {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      automaticallyImplyLeading: true,
      title: Text('',style: TextStyle(color: Colors.white),),
    );
  }
}
