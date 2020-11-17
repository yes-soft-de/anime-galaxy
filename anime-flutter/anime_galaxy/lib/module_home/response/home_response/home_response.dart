
import 'package:anime_galaxy/module_home/model/home_model/home_model.dart';
import 'package:anime_galaxy/module_home/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_home/response/coming_soon_episodes/coming_soon_episodes.dart';
import 'package:anime_galaxy/module_home/response/points/points_response.dart';
import 'package:anime_galaxy/module_home/response/watched_series_response/watched_series_response.dart';

class HomeResponse{
  List<WatchedSeriesResponse> watchedSeries;
  List<ComingSoonEpisodesResponse> comingSoonEpisodes;
  PointsResponse points;
  List<AnimeResponse> mayLikedSeries;

  HomeResponse({
    this.watchedSeries,
    this.mayLikedSeries,
    this.points,
    this.comingSoonEpisodes,

});
}