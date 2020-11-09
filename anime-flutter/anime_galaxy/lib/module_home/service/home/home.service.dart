import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
import 'package:anime_galaxy/module_home/manager/home/home.manager.dart';
import 'package:anime_galaxy/module_home/model/home_model/home_model.dart';
import 'package:anime_galaxy/module_home/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_home/response/coming_soon_episodes/coming_soon_episodes.dart';
import 'package:anime_galaxy/module_home/response/home_response/home_response.dart';
import 'package:inject/inject.dart';

@provide
class HomeService {
  final HomeManager _homeManager;
  final  AuthPrefsHelper _authPrefsHelper;
  HomeService(this._homeManager,this._authPrefsHelper);

  Future<HomeModel> getHomePageDetails() async {
    String userId = await _authPrefsHelper.getUserId();

    HomeResponse response = await _homeManager.getHomePageDetails(userId);

    HomeModel homeModel = new HomeModel(
      watchedSeries: getSeries(response.watchedSeries),
      points: response.points.points,
      mayLikeSeries: getSeries(response.mayLikedSeries),
      newEpisodes: getEpisodes(response.comingSoonEpisodes)
    );
    return homeModel;
  }



  List<Series> getSeries(List<AnimeResponse> animeResponses){
    List<Series> seriesList =[];

    animeResponses.forEach((element) {
      seriesList.add(new Series(
          id: element.id,
          name: element.name,
          image: element.mainImage,
          classification: element.categoryName));
    });
    return seriesList;
  }

  List<Episode> getEpisodes(List<ComingSoonEpisodesResponse> episodesList) {
    List<Episode> episodes = [];

    episodesList.forEach((element) {
      episodes.add(new Episode(
          //TODO : change this to real data
          classification: 'شاونين',
          image: element.image,
          episodeNumber: element.episodeNumber,
          season: element.seasonNumber,
          seriesName: element.animeName));
    });
    return episodes;
  }
}
