
import 'package:anime_galaxy/module_home/model/home_model/home_model.dart';
import 'package:anime_galaxy/module_home/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_home/response/coming_soon_episodes/coming_soon_episodes.dart';
import 'package:anime_galaxy/module_home/response/points/points_response.dart';

class HomeResponse{
  List<AnimeResponse> watchedSeries;
  List<ComingSoonEpisodesResponse> comingSoonEpisodes;
  PointsResponse points;
  //TODO : change this to the right response
  List<Series> mayLikedSeries;

  HomeResponse({
    this.watchedSeries,
    this.mayLikedSeries,
    this.points,
    this.comingSoonEpisodes,

});
}