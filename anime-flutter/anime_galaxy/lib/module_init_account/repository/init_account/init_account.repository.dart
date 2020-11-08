
import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_init_account/request/favourite_request/favourite_request.dart';
import 'package:anime_galaxy/module_init_account/response/category_respponse/category_response.dart';
import 'package:anime_galaxy/module_init_account/response/series_response/series_response.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart'; 
import 'package:inject/inject.dart';

@provide
class InitAccountRepository{
  final ApiClient _httpClient;

  InitAccountRepository(this._httpClient);

  Future<List<CategoryResponse>> getCategories()async{
    dynamic response = await _httpClient.get(Urls.API_CATEGORY);
    if(response == null ) return null;

    dynamic res = response['Data'];

    List<CategoryResponse> availableCategories = new List();
    for(int i = 0 ;i < res.length ; i ++){
      availableCategories.add(CategoryResponse.fromJson(res[i]));
      availableCategories[i].series = await getCategorySeries(availableCategories[i].id);
    }


    return availableCategories;
    
  }

  Future<List<SeriesResponse>> getCategorySeries(int categoryId)async{
      dynamic response = await _httpClient.get(Urls.API_ANIME_BY_CATEGORY+'$categoryId');
      if(response == null ) return [];

      List<SeriesResponse> series = [];

      for (int i =0; i< response['Data'].length ; i++){
        series.add(SeriesResponse.fromJson(response['Data'][i]));
      }
      return series;
  }


  Future<bool> addAnimesToWatch(List<FavouriteRequest> favouriteRequests)async{

    favouriteRequests.forEach((element)async {
      dynamic response = await _httpClient.post(Urls.API_ADD_FAVOURITE, {
        'userID':element.userID,
        'animeID':element.animeID,
        'categoryID':element.categoryID
      });

      if(response == null) return null;
    });

    return true;
    
  }

}