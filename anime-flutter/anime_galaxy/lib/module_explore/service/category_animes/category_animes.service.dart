

import 'package:anime_galaxy/module_explore/manager/category_animes/category_animes.manager.dart';
import 'package:anime_galaxy/module_explore/model/category_animes/category_animes.model.dart';
import 'package:anime_galaxy/module_explore/response/series_response/series_response.dart';
import 'package:inject/inject.dart';

@provide
class CategoryAnimesService{
  final CategoryAnimesManager _manager;

  CategoryAnimesService(this._manager);

  Future<List<CategoryAnimesModel>> getCategorySeries(int categoryId,String categoryName)async{
    List<SeriesResponse> response = await _manager.getCategorySeries(categoryId);
    if(response == null ) return null;
    List<CategoryAnimesModel> animes =[];

    response.forEach((element) {
      animes.add(
        new CategoryAnimesModel(
          animeImage:element.mainImage ,
          animeCategory: '',
          animeName: element.name,
          animeId: element.id,
          ageGroup: element.ageGroup,
          comments: element.comments,
          episodesCount: element.episodesCount,
          generalRating: element.generalRating,
          rating: element.rating,
          likes: element.interaction.love??0
        )
      );
    });

    return animes;
  }

  Future<List<CategoryAnimesModel>> searchAnime(
      int categoryId, String animeName) async {
    List<SeriesResponse>  response = await _manager.searchAnime(categoryId, animeName);
    if(response == null ) return null;
    List<CategoryAnimesModel> animes =[];

    response.forEach((element) {
      animes.add(
          new CategoryAnimesModel(
              animeImage:element.mainImage ,
              animeCategory: '',
              animeName: element.name,
              animeId: element.id,
              ageGroup: element.ageGroup,
              comments: element.comments,
              episodesCount: element.episodesCount,
              generalRating: element.generalRating,
              rating: element.rating,
              likes: element.interaction.love??0
          )
      );
    });

    return animes;
  }

}