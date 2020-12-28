

import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_explore/response/series_response/series_response.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

@provide
class CategoryAnimesRepository{
  final ApiClient _apiClient;

  CategoryAnimesRepository(this._apiClient);

  Future<List<SeriesResponse>> getCategorySeries(int categoryId)async{
    dynamic response = await _apiClient.get(Urls.API_ANIME_BY_CATEGORY+'$categoryId');
    if(response == null ) return [];

    List<SeriesResponse> series = [];
    for (int i =0; i< response['Data'].length ; i++){
      series.add(SeriesResponse.fromJson(response['Data'][i]));
    }
    return series;
  }
}