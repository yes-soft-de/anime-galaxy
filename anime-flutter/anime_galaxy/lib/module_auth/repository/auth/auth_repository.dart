import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

@provide
class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<bool> createUser(String uid) async {
    var result = await _apiClient.post(Urls.API_SIGN_UP, {
      'userID': uid,
      'password': uid,
      'roles': ['USER']
    });

    return result != null;
  }

  Future<String> getToken(String username, String password) async {
    var result = await _apiClient.post(
      Urls.API_CREATE_TOKEN,
      {
        'username': username,
        'password': password,
      },
    );

    if (result == null) {
      return null;
    }
    return result['token'];
  }
}
