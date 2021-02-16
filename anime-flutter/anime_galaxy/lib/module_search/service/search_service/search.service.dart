

import 'package:anime_galaxy/module_search/manager/search_manager/search.manager.dart';
import 'package:anime_galaxy/module_search/model/search_model/search_model.dart';
import 'package:anime_galaxy/module_search/response/search_response/search_reaponse.dart';
import 'package:inject/inject.dart';

@provide
class SearchService{
  final SearchManager _searchManager;
  SearchService(this._searchManager);

  Future<List<SearchModel>> seachAnime(String animeName)async{
    List<SearchResponse> response = await _searchManager.searchAnime(animeName);
    if(response == null ) return null;

    List<SearchModel> animesRetrived =[];

    response.forEach((element){
      animesRetrived.add(
        new SearchModel(
            animeImage:element.mainImage ,
            animeCategory: '',
            animeName: element.name,
            animeId: element.id,
            ageGroup: element.ageGroup??'0',
            comments: element.comments??0,
            episodesCount: element.episodesCount??0,
            generalRating: element.generalRating??'0',
            rating: element.rating??'0',
            likes: element.interactions.love??0
        )
      );
    });
   return animesRetrived;
  }
}