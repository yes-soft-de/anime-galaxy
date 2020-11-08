
import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_episode/episode_routes.dart';
import 'package:anime_galaxy/module_episode/ui/screen/episode_details_screen/episode_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class EpisodeModule extends YesModule{
  final EpisodeDetailsScreen _episodeDetailsScreen;

  EpisodeModule(this._episodeDetailsScreen);

  @override
  Map<String, WidgetBuilder> getRoutes(){
    return {
      EpisodeRoutes.ROUTE_EPISODE_DETAILS_SCREEN: (context) => _episodeDetailsScreen,
    };
  }

}