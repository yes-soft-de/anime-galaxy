
import 'package:anime_galaxy/module_home/manager/home/home.manager.dart';
import 'package:anime_galaxy/module_home/model/home_model/home_model.dart';
import 'package:anime_galaxy/module_home/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_home/response/coming_soon_episodes/coming_soon_episodes.dart';
import 'package:anime_galaxy/module_home/response/home_response/home_response.dart';
import 'package:inject/inject.dart';

@provide
class HomeService{
  final HomeManager _homeManager;

  HomeService(this._homeManager);

  Future<HomeModel> getHomePageDetails( ) async{
    //TODO : change the passed id to real id of logged in user
    HomeResponse response = await _homeManager.getHomePageDetails('zoz');

    response.watchedSeries.forEach((element) {
      print('soso + ${element.name}');
    });

    HomeModel homeModel = new HomeModel(
      watchedSeries: getWatchedSeries(response.watchedSeries),
      points: response.points.points,
      //TODO : change this to real data
      mayLikeSeries: response.mayLikedSeries,
      newEpisodes: getEpisodes(response.comingSoonEpisodes)
    );
    return homeModel;
  }

  List<Series> getWatchedSeries(List<AnimeResponse> animeResponses){
    List<Series> seriesList =[];

    animeResponses.forEach((element) {

      seriesList.add(
          new Series(
          name: element.name,
              //TODO : change this to real data
          image :'https://i.pinimg.com/236x/ab/46/ae/ab46ae9f35056e9a34072295fd974e9c.jpg',
        /*  image: element.mainImage,*/
          //TODO : change this to real data
          classification: 'شاونين'
            )
      );
    });
    return seriesList;
  }

  List<Episode> getEpisodes(List<ComingSoonEpisodesResponse> episodesList){
    List<Episode> episodes = [];

    episodesList.forEach((element) {
      episodes.add(
          new Episode(
            //TODO : change this to real data
            classification: 'شاونين',
            image: element.image,
            episodeNumber: element.episodeNumber,
            season: element.seasonNumber,
            seriesName: element.animeName
      ));
    });
    return episodes;
  }

}