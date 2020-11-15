import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_profile/profile_routes.dart';
import 'package:anime_galaxy/module_profile/ui/screen/my_profile/my_profile.dart';
import 'package:anime_galaxy/module_profile/ui/screen/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ProfileModule extends YesModule {
  final ProfileScreen _profileScreen;
  final MyProfileScreen _myProfileScreen;

  ProfileModule(
    this._profileScreen,
    this._myProfileScreen,
  );

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ProfileRoutes.ROUTE_PROFILE: (context) => _profileScreen,
      ProfileRoutes.ROUTE_EDIT_PROFILE: (context) => _myProfileScreen,
    };
  }
}
