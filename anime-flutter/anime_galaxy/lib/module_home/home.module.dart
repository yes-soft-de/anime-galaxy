import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_home/home.routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class HomeModule extends YesModule {
  HomeModule();

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {HomeRoutes.ROUTE_HOME: (context) => Scaffold()};
  }
}
