
import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
import 'package:anime_galaxy/module_explore/response/active_users_response/active_users_response.dart';
import 'package:anime_galaxy/module_explore/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_explore/response/category_respponse/category_response.dart';
import 'package:anime_galaxy/module_explore/response/comming_soon_response/comming_soon_response.dart';
import 'package:anime_galaxy/module_explore/response/expolre_response/explore_response.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

List<AnimeResponse> worldRecommendedSeries1 = [];
List<AnimeResponse> recommendedSeriesByYourFavourites1 = [];
List<ActiveUsersResponse> activeUsers1 = [];
List<CommingSoonResponse> comingSoon1 = [];
List<CategoryResponse> categories1 = [];

@provide
class ExploreRepository{
  final ApiClient _httpClient;
  final AuthPrefsHelper _authPrefsHelper;

  ExploreRepository(this._httpClient,this._authPrefsHelper);

  Future<ExploreResponse> getExploreScreenContent()async{


    await Future.wait([
       _getWorldRecommendedSeries(),
        _getRecommendedSeriesByYourFavourites(),
//      _getActiveUsers(),
      _getCommingSoonSeries(),
      _getCategories()
    ]) ;

    ExploreResponse result = new ExploreResponse(
//      activeUsers: activeUsers1,
      recommendedSeriesByYourFavourites: recommendedSeriesByYourFavourites1,
      worldRecommendedSeries: worldRecommendedSeries1,
      comingSoonSeries: comingSoon1,
      categories:  categories1,
    );

    return result;
  }

  Future<void> _getWorldRecommendedSeries()async {

    dynamic response = await _httpClient.get(Urls.API_HIGHEST_RATED_ANIMES);
    if(response == null) return [];

    List<AnimeResponse> worldRecommendedSeries = [];
    dynamic res = response['Data'];
    for(int i=0 ; i<res.length ; i++){
      worldRecommendedSeries.add(AnimeResponse.fromJson(res[i]));
    }
    worldRecommendedSeries1 = worldRecommendedSeries;
  }

  Future<void> _getRecommendedSeriesByYourFavourites()async {
    String userId = await _authPrefsHelper.getUserId();

    dynamic response = await _httpClient.get(Urls.API_HIGHEST_RATED_ANIMES_BY_USER+userId);
    if(response == null) return [];

    List<AnimeResponse> recommendedSeriesByYourFavourites = [];
    dynamic res = response['Data'];
    for(int i=0 ; i<res.length ; i++){
      recommendedSeriesByYourFavourites.add(AnimeResponse.fromJson(res[i]));
    }
    recommendedSeriesByYourFavourites1 = recommendedSeriesByYourFavourites;
  }

  Future<void> _getCommingSoonSeries()async {

    dynamic response = await _httpClient.get(Urls.API_COMING_SOON_ANIMES);
    if(response == null) return [];

    List<CommingSoonResponse> comingSoon = [];
    dynamic res = response['Data'];
    for(int i=0 ; i<res.length ; i++){
      comingSoon.add(CommingSoonResponse.fromJson(res[i]));
    }
    comingSoon1 = comingSoon;
  }

  Future<void> _getCategories()async{
    dynamic response = await _httpClient.get(Urls.API_CATEGORY);
    if(response == null ) return null;

    dynamic res = response['Data'];
    List<CategoryResponse> availableCategories = [];

    for(int i = 0 ;i < res.length ; i ++){
      availableCategories.add(CategoryResponse.fromJson(res[i]));
    }

    categories1 = availableCategories;

  }

}