

import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/anime_explor_list/ui/screen/explor_list_1/explor_list.dart';



import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

import 'explor_list_route.dart';

@provide
class ExplorListModule extends YesModule{
  final AnimeExploreList _animeExploreList;

  ExplorListModule(this._animeExploreList);


  @override
  Map<String, WidgetBuilder> getRoutes(){
    return {
      ExplorListRoutes.ROUTE_EXPLOR_LIST_PAGE: (context)=> _animeExploreList,
    };
  }
}