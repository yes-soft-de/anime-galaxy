import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_search/search_routes.dart';
import 'package:anime_galaxy/module_search/ui/screen/search_screen/seach_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SearchModule extends YesModule {
  final SearchScreen _searchScreen;

  SearchModule(
    this._searchScreen,
  );

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      SearchRoutes.ROUTE_Search: (context) => _searchScreen,
    };
  }
}
