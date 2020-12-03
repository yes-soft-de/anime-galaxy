import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/main_screen/main_screen_routes.dart';
import 'package:anime_galaxy/module_auth/auth_routes.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_localization/service/localization_service/localization_service.dart';
import 'package:anime_galaxy/module_profile/presistance/profile_shared_preferences.dart';
import 'package:anime_galaxy/module_profile/profile_routes.dart';
import 'package:anime_galaxy/module_theme/service/theme_service/theme_service.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/module_settings/widget/circular_setting/circular_image.dart';
import 'package:url_launcher/url_launcher.dart';

@provide
class SettingsPage extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;
  final SwapThemeDataService _themeDataService;
  final ProfileSharedPreferencesHelper _profileSharedPreferencesHelper;

  SettingsPage(
      this._authService,
      this._localizationService,
      this._themeDataService,
      this._profileSharedPreferencesHelper,
      );

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
  @override
  Widget build(BuildContext context) {
    double hight=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(

         child: Column(
           children: [
             Row(
               children: [
                 Expanded(
                   child: Container(
                     height: 150,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(3.0)),
                       image: DecorationImage(
                           image: NetworkImage(
                               'https://i.pinimg.com/236x/ec/e4/b0/ece4b097f87bd6a79d8e05cfd45d17d6--matte-painting-digital-paintings.jpg'
                           ),
                           fit: BoxFit.cover),

                     ),
                     child:  FutureBuilder(
                       future: widget._profileSharedPreferencesHelper.getImage(),
                       builder: (
                           BuildContext context,
                           AsyncSnapshot<String> snapshot
                       ){
                         return Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.all(Radius.circular(3.0)),
                             color: Colors.black.withOpacity(0.25),

                           ),
                           child: Align(
                               alignment: Alignment.center,
                               child: CircularImage(
                                 width: hight/8,
                                 height: hight/8,
                                 linkImg:snapshot.data ?? 'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w',
                               )
                           ),

                         );
                       }

                     ),
                   ),
                 )
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Column(



                   crossAxisAlignment: CrossAxisAlignment.end,

                   children: [
                     FutureBuilder(
                       future: widget._authService.username,
                       builder: (
                           BuildContext context,
                           AsyncSnapshot<String> snapshot,
                           ) {
                         return Text(
                           snapshot.data ?? S.of(context).notLoggedIn,
                           style: TextStyle(
                               fontFamily:'Roboto',
                               fontWeight: FontWeight.w600,
                               fontSize: 20
                           ),
                         );
                       },
                     ),
                     //TODO : change this to real data
                     Text('شونين - مغامرات',style: TextStyle(fontSize: 16),)
                   ],

                 ),
                 ButtonTheme(
                   height: 50,
                   child: FlatButton(
                     color:ProjectColors.ThemeColor,
                     shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                     onPressed: (){
                       Navigator.pushNamed(context, ProfileRoutes.ROUTE_EDIT_PROFILE,arguments: ProfileRoutes.ROUTE_PROFILE);
                     },
                     child:Text(
                       S.of(context).edit,
                       style: TextStyle(
                           fontSize: 16,
                           color: Colors.white
                       ),
                     ) ,
                   ),
                 ),
               ],
             ),

             //dark mode
             Padding(
               padding: const EdgeInsets.all(4.0),
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(4)),
                   color: Colors.black12,
                 ),
                 child: Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: Flex(
                     direction: Axis.horizontal,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         S.of(context).darkMode,
                         style: TextStyle(
                           fontFamily:'Roboto',
                         ),
                       ),
                       StreamBuilder(
                         stream: widget._themeDataService.darkModeStream,
                         initialData: false,
                         builder: (
                             BuildContext context,
                             AsyncSnapshot<bool> snapshot,
                             ) {
                           return Switch(
                               value:
                               Theme.of(context).brightness == Brightness.dark,
                               onChanged: (mode) {
                                 widget._themeDataService
                                     .switchDarkMode(mode)
                                     .then((value) {});
                               });
                         },
                       ),
                     ],
                   ),
                 ),
               ),
             ),
             // notification
             Padding(
               padding: const EdgeInsets.all(4.0),
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(4)),
                   color: Colors.black12,
                 ),
                 child: Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: Flex(
                     direction: Axis.horizontal,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(
                         children: [
                           Icon(Icons.notifications, size: 18,),
                           Text(
                             S.of(context).notifications,
                             style: TextStyle(
                               fontFamily:'Roboto',
                             ),
                           ),
                         ],
                       ),

                       Switch(
                           value:notifications,
                           onChanged: (mode) {
                             notifications = mode;
                             setState(() {

                             });
                           }
                       )

                     ],
                   ),
                 ),
               ),
             ),
             // account
//             Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(4)),
//                   color: Colors.black12,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: GestureDetector(
//                     onTap: (){},
//                     child: Flex(
//                       direction: Axis.horizontal,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.person, size: 18,),
//                             Text(
//                               S.of(context).account,
//                               style: TextStyle(
//                                 fontFamily:'Roboto',
//                               ),
//                             ),
//                           ],
//                         ),
//
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
             // privacy
             Padding(
               padding: const EdgeInsets.all(4.0),
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(4)),
                   color: Colors.black12,
                 ),
                 child: Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: GestureDetector(
                     onTap: () {
                       canLaunch('https://www.google.com').then((value) {
                         launch('https://www.google.com');
                       });
                     },
                     child: Flex(
                       direction: Axis.horizontal,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             Icon(Icons.work, size: 18,),
                             Text(
                               S.of(context).privacy,
                               style: TextStyle(
                                 fontFamily:'Roboto',
                               ),
                             ),
                           ],
                         ),


                       ],
                     ),
                   ),
                 ),
               ),
             ),
             // help
             Padding(
               padding: const EdgeInsets.all(4.0),
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(4)),
                   color: Colors.black12,
                 ),
                 child: Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: GestureDetector(
                     onTap: () {
                       canLaunch('https://www.google.com').then((value) {
                         launch('https://www.google.com');
                       });
                     },
                     child: Flex(
                       direction: Axis.horizontal,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             Icon(Icons.help, size: 18,),
                             Text(
                               S.of(context).help,
                               style: TextStyle(
                                 fontFamily:'Roboto',
                               ),
                             ),
                           ],
                         ),


                       ],
                     ),
                   ),
                 ),
               ),
             ),

            //login logout
             Padding(
               padding: const EdgeInsets.all(4.0),
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(4)),
                   color: Colors.black12,
                 ),
                 child: Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: FutureBuilder(
                     future: widget._authService.isLoggedIn,
                     initialData: false,
                     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                       if (snapshot.data) {
                         return Flex(
                           direction: Axis.horizontal,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               S.of(context).signOut,
                               style: TextStyle(
                                 fontFamily:'Roboto',
                               ),
                             ),
                             IconButton(
                                 icon: Icon(Icons.power_settings_new,color: ProjectColors.ThemeColor,),
//                             icon: Icon(Icons.arrow_drop_down_circle),
                                 onPressed: () {
                                   widget._authService.logout().then((value) {
                                     Navigator.pushNamedAndRemoveUntil(
                                       context,
                                       MainScreenRoute.MAIN_SCREEN_ROUTE,
                                           (route) => false,
                                     );
                                   });
                                 })
                           ],
                         );
                       } else {
                         return Flex(
                           direction: Axis.horizontal,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               S.of(context).login,
                               style: TextStyle(
                                 fontFamily:'Roboto',
                               ),
                             ),
                             IconButton(
//                            icon: Icon(Icons.login),
                                 icon: Icon(Icons.radio),
                                 onPressed: () {
                                   Navigator.of(context)
                                       .pushNamed(AuthRoutes.ROUTE_AUTHORIZE);
                                 })
                           ],
                         );
                       }
                     },
                   ),
                 ),
               ),
             ),
           ],
          ),
        ),
      ),
    );
  }
}
