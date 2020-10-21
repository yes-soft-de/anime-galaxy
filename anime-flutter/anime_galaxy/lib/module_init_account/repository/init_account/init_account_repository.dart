
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

@provide
class InitAccountRepository{
  final ApiClient _httpClient;

  InitAccountRepository(this._httpClient);


}