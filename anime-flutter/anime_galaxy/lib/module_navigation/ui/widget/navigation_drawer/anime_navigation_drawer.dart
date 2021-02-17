import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_explore/explore_routes.dart';
import 'package:anime_galaxy/module_home/home.routes.dart';
import 'package:anime_galaxy/module_notification/notification_routes.dart';
import 'package:anime_galaxy/module_profile/presistance/profile_shared_preferences.dart';
import 'package:anime_galaxy/module_settings/setting_routes.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inject/inject.dart';
import 'package:url_launcher/url_launcher.dart';

@provide
class AnimeNavigationDrawer extends StatelessWidget {
  final ProfileSharedPreferencesHelper _profileSharedPreferencesHelper;

  AnimeNavigationDrawer(
    this._profileSharedPreferencesHelper,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 252,
      child: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/logo.jpg',
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.softLight,
            ),
          ),

          Positioned.fill(
              child: Container(
            color: Colors.black54,
          )),

          // Foreground
          Positioned.fill(
              child: Container(
            color: ProjectColors.ThemeColor,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // region Header
                /* Profile
                  FutureBuilder(
                    future: profileService.getProfile(),
                    builder: (BuildContext context,
                        AsyncSnapshot<ProfileModel> snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return Container();
                      }
                      if (snapshot.data.name == null) {
                        return Container();
                      }
                      return Container(
                        height: 116,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Color(0x8FFFFFFF)
                            : Color(0x8F000000),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Flex(
                            direction: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // User Image
                              Container(
                                height: 56,
                                width: 56,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(snapshot.data.image))),
                              ),
                              // User Details
                              Flex(
                                direction: Axis.vertical,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  !snapshot.hasData
                                      ? Text(S.of(context).loading)
                                      : Text(
                                          '${snapshot.data.name}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  */
                FutureBuilder(
                  future: _profileSharedPreferencesHelper.getCoverImage(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:snapshot.data!=null?
                                  NetworkImage(snapshot.data):
                                  AssetImage('assets/images/orange2.jpg'),
                              fit: BoxFit.cover)),
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        //profile image
                        child: Container(
                          alignment: Alignment(0.0, 5.5),
                          child: FutureBuilder(
                              future:
                                  _profileSharedPreferencesHelper.getImage(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapShot) {
                                return CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 50.0,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      snapShot.data ??
                                          'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d',
                                    ),
                                    radius: 48.0,
                                  ),
                                );
                              }),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: FutureBuilder(
                    future: _profileSharedPreferencesHelper.getUsername(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapShot) {
                      return Text(snapShot.data ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ));
                    },
                  ),
                ),

//                Container(
//                  height: 150,
//                  color: Colors.black26,
//                  child: Row(
//                    children: [
//                      FutureBuilder(
//                        future: _profileSharedPreferencesHelper.getImage(),
//                        builder: (BuildContext context,
//                            AsyncSnapshot<String> snapShot) {
//                          return CircularImage(
//                            linkImg: snapShot.data ??
//                                'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d',
//                            width: 40,
//                            height: 40,
//                          );
//                        },
//                      ),
//                      SizedBox(
//                        width: 20,
//                      ),
//                      Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          FutureBuilder(
//                            future: _profileSharedPreferencesHelper.getUsername(),
//                            builder: (BuildContext context,
//                                AsyncSnapshot<String> snapShot) {
//                              return Text(snapShot.data ?? '',
//                                  style: TextStyle(
//                                    fontSize: 18,
//                                    fontFamily: 'Roboto',
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.bold,
//                                  ));
//                            },
//                          ),
//                          Text('شاونين-مغامرات',
//                              style: TextStyle(
//                                fontSize: 14,
//                                fontFamily: 'Roboto',
//                                color: Colors.white,
//                              )),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),

                // region Sections
                Flex(
                  direction: Axis.vertical,
                  children: [
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.of(context)
//                            .pushNamed(HomeRoutes.ROUTE_HOME, arguments: 0);
//                      },
//                      child: Container(
//                        color: Color(0xffff9600),
//                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
//                        child: Flex(
//                          direction: Axis.horizontal,
//                          children: [
//                            Icon(
//                              Icons.dashboard,
//                              color: Colors.white,
//                            ),
//                            Container(
//                              width: 16,
//                            ),
//                            Text(
//                              S.of(context).feed,
//                              style: TextStyle(
//                                  fontFamily: 'Roboto', color: Colors.white),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.of(context)
//                            .pushNamed(ExploreRoutes.EXPLORE_SCREEN);
//                      },
//                      child: Padding(
//                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
//                        child: Flex(
//                          direction: Axis.horizontal,
//                          children: [
//                            Icon(
//                              Icons.explore,
//                              color: Colors.white,
//                            ),
//                            Container(
//                              width: 16,
//                            ),
//                            Text(
//                              S.of(context).explore,
//                              style: TextStyle(
//                                  fontFamily: 'Roboto', color: Colors.white),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.of(context).pushNamed(
//                          NotificationRoutes.ROUTE_NOTIFICATION_SCREEN,
//                          arguments: 1,
//                        );
//                      },
//                      child: Container(
//                        color: Color(0xffff9600),
//                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
//                        child: Flex(
//                          direction: Axis.horizontal,
//                          children: [
//                            Icon(
//                              Icons.notifications,
//                              color: Colors.white,
//                            ),
//                            Container(
//                              width: 16,
//                            ),
//                            Text(S.of(context).notifications,
//                                style: TextStyle(
//                                    fontFamily: 'Roboto', color: Colors.white)),
//                          ],
//                        ),
//                      ),
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.of(context).pushNamed(
//                            SettingRoutes.SETTING_SCREEN_ROUTE,
//                            arguments: 1);
//                      },
//                      child: Padding(
//                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
//                        child: Flex(
//                          direction: Axis.horizontal,
//                          children: [
//                            Icon(
//                              Icons.settings,
//                              color: Colors.white,
//                            ),
//                            Container(
//                              width: 16,
//                            ),
//                            Text(S.of(context).settings,
//                                style: TextStyle(
//                                    fontFamily: 'Roboto', color: Colors.white)),
//                          ],
//                        ),
//                      ),
//                    ),
                    GestureDetector(
                      onTap: () {
                        canLaunch('https://www.google.com').then((value) {
                          launch('https://www.google.com');
                        });
                      },
                      child: Container(
                        color: Color(0xffff9600),
                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(S.of(context).tos,
                                style: TextStyle(
                                    fontFamily: 'Roboto', color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        canLaunch('https://www.google.com').then((value) {
                          launch('https://www.google.com');
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(
                              S.of(context).privacyPolicy,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // endregion

                // region Social Links
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        canLaunch('https://www.google.com').then((value) {
                          launch('https://www.google.com');
                        });
                      },
                      child: Container(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                            'assets/images/twitter.svg',
                            color: Colors.white,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        canLaunch('https://www.google.com').then((value) {
                          launch('https://www.google.com');
                        });
                      },
                      child: Container(
                          height: 24,
                          width: 24,
                          child: Image.asset(
                            'assets/images/instagram.png',
                            color: Colors.white,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        canLaunch('https://www.google.com').then((value) {
                          launch('https://www.google.com');
                        });
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        child: SvgPicture.asset(
                          'assets/images/facebook.svg',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                // endregion

                // region Feedback Button
//                GestureDetector(
//                  onTap: () {
//                    canLaunch('https://www.google.com').then((value) {
//                      if (value) {
//                        launch('https://www.google.com');
//                      }
//                    });
//                  },
//                  child: Container(
//                    width: 252,
//                    height: 48,
//                    alignment: Alignment.center,
//                    color: Colors.black26,
////                      color: Theme.of(context).brightness == Brightness.dark
////                          ? Colors.black
////                          : Colors.white,
//                    child: Text(
//                      S.of(context).feedback,
//                      style: TextStyle(
//                        fontFamily: 'Roboto',
//                      ),
//                    ),
//                  ),
//                ),
                // endregion
                Container(),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
