import 'package:anime_galaxy/module_anime/response/favourite_response/favourite_response.dart';
import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
import 'package:anime_galaxy/module_profile/response/following_activities_response/following_activities_response.dart';
import 'package:anime_galaxy/module_profile/response/follwoing_response/following_response.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:anime_galaxy/module_profile/request/create_profile.dart';
import 'package:anime_galaxy/module_profile/response/profile_response/profile_response.dart';

@provide
class MyProfileRepository {
  final ApiClient _apiClient;
  final AuthPrefsHelper _authPrefsHelper;

  MyProfileRepository(this._apiClient,this._authPrefsHelper);

  Future<ProfileResponse> getProfile(String userId)async{
    String loggedUser = await _authPrefsHelper.getUserId();

    dynamic response = await _apiClient.get(Urls.API_PROFILE+userId);
    if(response == null ) return null;
    ProfileResponse result = ProfileResponse.fromJson(response['Data']);
    result.followingActivitiesResponse = await _getFollowingActivities(userId);
    result.favourites = await _getWatchedSeries(userId);
    result.followingNumber = await _getFollowingNumber(userId);


    result.isFollowed = await _isFollowed(loggedUser,userId );

    return result;

  }

  Future<int> _getFollowingNumber(String userId)async{
    dynamic response = await _apiClient.get(Urls.API_FOLLOWING_USERS+userId);
    if(response == null ) return 0;

    return response['Data'].length;
  }

  Future<List<FollowingActivitiesResponse>> _getFollowingActivities(String userId)async{
    dynamic response = await _apiClient.get(Urls.API_FOLLOWING_ACTIVITIES+userId);
    if(response == null ) return [];
    List<FollowingActivitiesResponse> result = [];
    dynamic res = response['Data'];

    for(int i=0 ; i<res.length ; i++){
      result.add(
        FollowingActivitiesResponse.fromJson(res[i])
      );
    }
    return result;
  }

  Future<List<FavouriteResponse>> _getWatchedSeries(String userId)async{
    dynamic response = await _apiClient.get(Urls.API_FAVOURITE_ANIMES +'$userId');

    if(response == null) return [];

    List<FavouriteResponse> series = [];
    dynamic res = response['Data'];
    for(int i = 0; i<res.length; i++){
      series.add(FavouriteResponse.fromJson(res[i]));
    }

    return series;
  }

  Future<bool> follow(String userId,String friendId) async{
    dynamic response = await _apiClient.post(Urls.API_FOLLOW, {
      'userID':userId,
      'friendID':friendId
    });

    return response == null ?
    null:
    response['status_code']=='201'?
    true:
    false;
  }

  Future<bool> unFollow(String userId,String friendId)async{
     dynamic response = await _apiClient.delete(Urls.API_FOLLOW+'/$userId/$friendId');
     return response == null ?
     null:
     response['status_code']=='401'?
     true:
     false;

  }

  Future<bool> _isFollowed(String userId , String friendId)async{
    dynamic following = await _apiClient.get(Urls.API_FOLLOWING_USERS+userId);
    if(following == null ) return false;

    dynamic res = following['Data'];
    for(int i=0 ; i <res.length ; i++){
      FollowingUsersResponse follow = FollowingUsersResponse.fromJson(res[i]);
      if(friendId == follow.friendID ) return true;
    }

    return false;
  }
  
  Future<ProfileResponse> getMyProfile() async {
    Map<String, dynamic> response = await _apiClient.get(Urls.API_PROFILE);

    return response ?? ProfileResponse.fromJson(response);
  }

  Future<ProfileResponse> createMyProfile(
      CreateProfileRequest profileRequest) async {
    Map<String, dynamic> response =
        await _apiClient.post(Urls.API_PROFILE, profileRequest.toJson());

    return response == null ? null : ProfileResponse.fromJson(response);
  }
}
