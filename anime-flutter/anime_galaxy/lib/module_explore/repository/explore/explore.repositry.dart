
import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_explore/response/active_users_response/active_users_response.dart';
import 'package:anime_galaxy/module_explore/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_explore/response/expolre_response/explore_response.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';


@provide
class ExploreRepository{
  final ApiClient _httpClient;

  ExploreRepository(this._httpClient);

  Future<ExploreResponse> getExploreScreenContent()async{
    List<AnimeResponse> worldRecommendedSeries = await  getWorldRecommendedSeries();
    List<AnimeResponse> recommendedSeriesByYourFavourites = await  getRecommendedSeriesByYourFavourites();
    List<ActiveUsersResponse> activeUsers = await getActiveUsers();

    ExploreResponse result = new ExploreResponse(
      activeUsers: activeUsers,
      recommendedSeriesByYourFavourites: recommendedSeriesByYourFavourites,
      worldRecommendedSeries: worldRecommendedSeries
    );

    return result;
  }

  Future<List<AnimeResponse>> getWorldRecommendedSeries()async {

    dynamic response = await _httpClient.get(Urls.API_HIGHEST_RATED_ANIMES);
    if(response == null) return [];

    List<AnimeResponse> worldRecommendedSeries = [];
    dynamic res = response['Data'];
    for(int i=0 ; i<res.length ; i++){
      worldRecommendedSeries.add(AnimeResponse.fromJson(res[i]));
    }

    return worldRecommendedSeries;
  }

  Future<List<AnimeResponse>> getRecommendedSeriesByYourFavourites()async {

    dynamic response = await _httpClient.get(Urls.API_HIGHEST_RATED_ANIMES_BY_USER+'zoz');
    if(response == null) return [];

    List<AnimeResponse> recommendedSeriesByYourFavourites = [];
    dynamic res = response['Data'];
    for(int i=0 ; i<res.length ; i++){
      recommendedSeriesByYourFavourites.add(AnimeResponse.fromJson(res[i]));
    }

    return recommendedSeriesByYourFavourites;
  }

  Future<List<ActiveUsersResponse>> getActiveUsers()async{
   dynamic response = await _httpClient.get(Urls.API_ACTIVE_USERS);

   if(response == null) return [];

   List<ActiveUsersResponse> activeUsers = [];
   dynamic res = response['Data'];
   for(int i=0 ; i<res.length ; i++){
     activeUsers.add(ActiveUsersResponse.fromJson(res[i]));
   }

   return activeUsers;
  }


}