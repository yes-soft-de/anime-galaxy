import 'package:anime_galaxy/module_auth/request/login/login_request.dart';
import 'package:anime_galaxy/module_auth/request/register/registerRequest.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';

@provide
class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<bool> register(RegisterRequest request) async {
    var result = await _apiClient.post(Urls.API_SIGN_UP, {
      'userID': request.userId,
      'password': request.password,
    });
    if(result == null ) return false;

    var createProfileResult = await createProfile(request.userId,request.userName);
    //TODO : what if it doesn't initiate user points to 0
    await _registerPointsForUser(request.userId);
    return result != null && createProfileResult != null;
  }

  Future<bool> createProfile(String userId,String userName) async{
   var result = await _apiClient.post(Urls.API_CREATE_PROFILE, {

       'userID': userId,

       'userName': userName,

       'location': '',

       'story': '',

       'image': ''

   });
   return result != null;

  }

  Future<bool> _registerPointsForUser(String userId)async{
     dynamic response = await _apiClient.post(Urls.API_REGISTER_POINTS, {
       "userID":userId,
       "points":0
     });
  }

  Future<bool> login(LoginRequest request) async {
    var result = await _apiClient.post(
      Urls.API_CREATE_TOKEN,
      {
        'username': request.userId,
        'password': request.password,
      },
    );

    if (result == null) {
      return null;
    }
    return true;
  }
}
