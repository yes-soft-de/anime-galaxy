import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_home/home.routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

import 'ui/screens/home_screen.dart';

@provide
class HomeModule extends YesModule {
  final HomeScreen _homeScreen;
  HomeModule(this._homeScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {HomeRoutes.ROUTE_HOME: (context) => Scaffold()};
  }
}
