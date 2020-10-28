import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_home/model/home_model/home_model.dart';
import 'package:anime_galaxy/module_home/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_home/response/coming_soon_episodes/coming_soon_episodes.dart';
import 'package:anime_galaxy/module_home/response/home_response/home_response.dart';
import 'package:anime_galaxy/module_home/response/points/points_response.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';


List<Series> mayLikedSeries =[
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
 ];



@provide
class HomeRepository{
  final ApiClient _httpClient;

  HomeRepository(this._httpClient);

  Future<HomeResponse> getHomePageDetails(String userId) async{

    PointsResponse points = await getUserPoints(userId);
    List<ComingSoonEpisodesResponse> episodes = await getEpisodesComingSoon();
    List<AnimeResponse> watchedSeries = await getWatchedSeries(userId);
    List<Series> mayLikedSeries = await getMayLikedSeries();


    HomeResponse result = new HomeResponse(
      watchedSeries: watchedSeries,
      comingSoonEpisodes: episodes,
      mayLikedSeries: mayLikedSeries,
      points: points
    );

    return result;
  }

  Future<List<AnimeResponse>> getWatchedSeries(String userId)async{
   dynamic response = await _httpClient.get(Urls.API_FAVOURITE_ANIMES +'$userId');

   if(response == null) return null;
   
   List<AnimeResponse> series = [];
   dynamic res = response['Data'];
   for(int i = 0; i<res.length; i++){
     series.add(await getAnime(res[i]['animeID']));
   }

   return series;
  }
  
  Future<AnimeResponse> getAnime(int animeId)async{
    dynamic response = await _httpClient.get(Urls.API_ANIME+'/$animeId');

    if(response == null) return null;


    AnimeResponse anime = new AnimeResponse();
    anime = AnimeResponse.fromJson(response['Data']);

    return anime;
  }

  //TODO : change this when there is a result from the backend
  Future<List<Series>> getMayLikedSeries()async{
    return mayLikedSeries;
  }


  Future<List<ComingSoonEpisodesResponse>> getEpisodesComingSoon()async{
    dynamic response = await _httpClient.get(Urls.API_EPISODES_COMING_SOON);

    if(response == null) return null;

    List<ComingSoonEpisodesResponse> episodes = [];

    dynamic res = response['Data'];
    for(int i=0 ; i< res.length ; i++){
      episodes.add(ComingSoonEpisodesResponse.fromJson(res[i]));
    }

    return episodes;
  }

  Future<PointsResponse> getUserPoints(String userId)async{
    dynamic response = await _httpClient.get(Urls.API_USER_POINTS+userId);
    dynamic res = response['Data'];
    return PointsResponse.fromJson(res);
  }
}