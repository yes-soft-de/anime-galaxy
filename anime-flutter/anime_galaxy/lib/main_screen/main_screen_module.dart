import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/main_screen/main_screen_routes.dart';
import 'package:anime_galaxy/main_screen/ui/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class MainScreenModule extends YesModule {
  final MainScreen _mainScreen;

  MainScreenModule(this._mainScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      MainScreenRoute.MAIN_SCREEN_ROUTE: (context) => _mainScreen,
    };
  }
}
