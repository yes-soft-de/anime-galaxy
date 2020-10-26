
import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_init_account/response/category_respponse/category_response.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart'; 
import 'package:inject/inject.dart';

@provide
class InitAccountRepository{
  final ApiClient _httpClient;

  InitAccountRepository(this._httpClient);

  Future<List<CategoryResponse>> getCategories()async{
    dynamic response = await _httpClient.get(Urls.API_CATEGORY);
    if(response == null ) return null;

    dynamic res = response["Data"];

    List<CategoryResponse> availableCategories = new List();
    for(int i = 0 ;i < res.length ; i ++){
      availableCategories.add(CategoryResponse.fromJson(res[i]));
    }


    return availableCategories;
    
  }

}