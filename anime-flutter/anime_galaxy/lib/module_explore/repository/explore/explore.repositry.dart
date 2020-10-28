
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

@provide
class ExploreRepository{
  final ApiClient _httpClient;

  ExploreRepository(this._httpClient);

  Future<void> getExploreScreenContent()async{

  }


}