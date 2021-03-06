import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_explore/explore_routes.dart';
import 'package:anime_galaxy/module_explore/ui/screen/category_animes_screen/category_animes_screen.dart';
import 'package:anime_galaxy/module_explore/ui/screen/explore_screen/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ExploreModule extends YesModule {
  final ExploreScreen _exploreScreen;
  final CategoryAnimesScreen _categoryAnimesScreen;

  ExploreModule(
      this._exploreScreen,
      this._categoryAnimesScreen,
      );

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ExploreRoutes.EXPLORE_SCREEN: (context) => _exploreScreen,
      ExploreRoutes.CATEGORY_ANIMES_SCREEN: (context) => _categoryAnimesScreen,
    };
  }
}
