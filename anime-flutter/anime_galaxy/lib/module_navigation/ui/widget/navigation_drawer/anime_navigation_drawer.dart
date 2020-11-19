
import 'package:anime_galaxy/module_notification/notification_routes.dart';
import 'package:anime_galaxy/module_settings/setting_routes.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_home/home.routes.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimeNavigationDrawer extends StatelessWidget {
  AnimeNavigationDrawer();

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
                     Container(
                       height: 50
                        ),
                       

                    // region Sections
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(HomeRoutes.ROUTE_HOME, arguments: 0);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Icon(
                                  Icons.dashboard,
                                  color: Colors.white,
                                ),
                                Container(
                                  width: 16,
                                ),
                                Text(
                                  S.of(context).feed,
                                  style: TextStyle(
                                      fontFamily:'Roboto',
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
//                          Navigator.of(context)
//                              .pushNamed(HomeRoutes.ROUTE_HOME, arguments: 0);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Icon(
                                  Icons.explore,
                                  color: Colors.white,
                                ),
                                Container(
                                  width: 16,
                                ),
                                Text(
                                  S.of(context).explore,
                                  style: TextStyle(
                                      fontFamily:'Roboto',
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              NotificationRoutes.ROUTE_NOTIFICATION_SCREEN,
                              arguments: 1,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                ),
                                Container(
                                  width: 16,
                                ),
                                Text(
                                    S.of(context).notifications,
                                    style: TextStyle(
                                        fontFamily:'Roboto',
                                        color: Colors.white
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed( SettingRoutes.SETTING_SCREEN_ROUTE);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                                Container(
                                  width: 16,
                                ),
                                Text(
                                    S.of(context).settings,
                                    style: TextStyle(
                                        fontFamily:'Roboto',
                                        color: Colors.white
                                    )
                                ),
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
                                  Icons.info,
                                  color: Colors.white,
                                ),
                                Container(
                                  width: 16,
                                ),
                                Text(
                                    S.of(context).tos,
                                    style: TextStyle(
                                        fontFamily:'Roboto',
                                        color: Colors.white
                                    )
                                ),
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
                                    fontFamily:'Roboto',
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
                    GestureDetector(
                      onTap: () {
                        canLaunch('https://www.google.com').then((value) {
                          if (value) {
                            launch('https://www.google.com');
                          }
                        });
                      },
                      child: Container(
                        width: 252,
                        height: 48,
                        alignment: Alignment.center,
                        color: Colors.black26,
//                      color: Theme.of(context).brightness == Brightness.dark
//                          ? Colors.black
//                          : Colors.white,
                        child: Text(
                            S.of(context).feedback,
                          style: TextStyle(
                            fontFamily:'Roboto',
                          ),
                        ),
                      ),
                    ),
                    // endregion
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
