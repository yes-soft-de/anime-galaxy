
import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
import 'package:anime_galaxy/module_explore/response/active_users_response/active_users_response.dart';
import 'package:anime_galaxy/module_explore/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_explore/response/comming_soon_response/comming_soon_response.dart';
import 'package:anime_galaxy/module_explore/response/expolre_response/explore_response.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';


@provide
class ExploreRepository{
  final ApiClient _httpClient;
  final AuthPrefsHelper _authPrefsHelper;

  ExploreRepository(this._httpClient,this._authPrefsHelper);

  Future<ExploreResponse> getExploreScreenContent()async{
    List<AnimeResponse> worldRecommendedSeries = await  _getWorldRecommendedSeries();
    List<AnimeResponse> recommendedSeriesByYourFavourites = await  _getRecommendedSeriesByYourFavourites();
    List<ActiveUsersResponse> activeUsers = await _getActiveUsers();
    List<CommingSoonResponse> comingSoon = await _getCommingSoonSeries();

    ExploreResponse result = new ExploreResponse(
      activeUsers: activeUsers,
      recommendedSeriesByYourFavourites: recommendedSeriesByYourFavourites,
      worldRecommendedSeries: worldRecommendedSeries,
      comingSoonSeries: comingSoon,
    );

    return result;
  }

  Future<List<AnimeResponse>> _getWorldRecommendedSeries()async {

    dynamic response = await _httpClient.get(Urls.API_HIGHEST_RATED_ANIMES);
    if(response == null) return [];

    List<AnimeResponse> worldRecommendedSeries = [];
    dynamic res = response['Data'];
    for(int i=0 ; i<res.length ; i++){
      worldRecommendedSeries.add(AnimeResponse.fromJson(res[i]));
    }

    return worldRecommendedSeries;
  }

  Future<List<AnimeResponse>> _getRecommendedSeriesByYourFavourites()async {
    String userId = await _authPrefsHelper.getUserId();

    dynamic response = await _httpClient.get(Urls.API_HIGHEST_RATED_ANIMES_BY_USER+userId);
    if(response == null) return [];

    List<AnimeResponse> recommendedSeriesByYourFavourites = [];
    dynamic res = response['Data'];
    for(int i=0 ; i<res.length ; i++){
      recommendedSeriesByYourFavourites.add(AnimeResponse.fromJson(res[i]));
    }

    return recommendedSeriesByYourFavourites;
  }



  Future<List<ActiveUsersResponse>> _getActiveUsers()async{
   dynamic response = await _httpClient.get(Urls.API_ACTIVE_USERS);

   if(response == null) return [];

   List<ActiveUsersResponse> activeUsers = [];
   dynamic res = response['Data'];
   for(int i=0 ; i<res.length ; i++){
     activeUsers.add(ActiveUsersResponse.fromJson(res[i]));
   }

   return activeUsers;
  }


  Future<List<CommingSoonResponse>> _getCommingSoonSeries()async {

    dynamic response = await _httpClient.get(Urls.API_COMING_SOON_ANIMES);
    if(response == null) return [];

    List<CommingSoonResponse> recommendedSeriesByYourFavourites = [];
    dynamic res = response['Data'];
    for(int i=0 ; i<res.length ; i++){
      recommendedSeriesByYourFavourites.add(CommingSoonResponse.fromJson(res[i]));
    }

    return recommendedSeriesByYourFavourites;
  }

}