
import 'package:anime_galaxy/module_profile/ui/screen/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_profile/profile_routes.dart';

@provide
class ProfileModule extends YesModule {
  final ProfileScreen _profileScreen;

  ProfileModule(this._profileScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {ProfileRoutes.ROUTE_PROFILE: (context) => _profileScreen};
  }
}
