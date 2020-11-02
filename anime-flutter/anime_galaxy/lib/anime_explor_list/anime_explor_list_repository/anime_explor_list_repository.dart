
import 'package:anime_galaxy/anime_explor_list/model/AllAnimeData.dart';
import 'package:anime_galaxy/anime_explor_list/model/AllAnimeModel.dart';
import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

@provide
class AnimeExplorListRepository{

   ApiClient _apiClient;

  AnimeExplorListRepository(this._apiClient);


  Future<List<AllAnimeData>> getAllSeries() async {
//    print("url= ${Urls.API_ALL_ANIME}");
   Map<String, dynamic> response = await _apiClient.get(Urls.API_ANIME);

    print("request= finish");

   if (response == null) {
     return null;
   } else if(response['status_code']==200){

     AllAnimeModel item=AllAnimeModel.fromJson(response);

     if(item!=null) return item.allData;
     return null;

   }else{
     return null;
   }
}
}