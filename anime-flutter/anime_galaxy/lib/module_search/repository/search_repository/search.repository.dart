

import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:anime_galaxy/module_search/response/search_response/search_reaponse.dart';
import 'package:inject/inject.dart';

@provide
class SearchRepository{
  final ApiClient _apiClient;

  SearchRepository(this._apiClient);

  Future<List<SearchResponse>> searchAnime(String animeName)async {
   dynamic response = await _apiClient.get(Urls.API_SEARCH_ANIME+animeName);
   if(response == null ) return null;

   dynamic res = response['Data'];
   List<SearchResponse> searchResult =[];
   for(int i=0; i<res.length; i++){
     searchResult.add(SearchResponse.fromJson(res[i]));
   }
   return searchResult;
  }
}