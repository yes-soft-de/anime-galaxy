import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_anime/response/favourite_response/favourite_response.dart';
import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:anime_galaxy/module_profile/request/create_profile.dart';
import 'package:anime_galaxy/module_profile/response/following_activities_response/following_activities_response.dart';
import 'package:anime_galaxy/module_profile/response/follwoing_response/following_response.dart';
import 'package:anime_galaxy/module_profile/response/previous_comments_response/previous_comments_response.dart';
import 'package:anime_galaxy/module_profile/response/profile_response/profile_response.dart';
import 'package:inject/inject.dart';

import '../../../consts/urls.dart';

int followingNumber1 = 0;
List<FollowingActivitiesResponse> followingActivitiesResponse1 = [];
List<FavouriteResponse> favourites1 = [];
bool isFollowed1 = false;
PreviousCommentsResponse previousCommentsResponse1 = new PreviousCommentsResponse(
  animeComments: [],
  episodeComments: [],
);

@provide
class MyProfileRepository {
  final ApiClient _apiClient;
  final AuthPrefsHelper _authPrefsHelper;

  MyProfileRepository(this._apiClient, this._authPrefsHelper);

  Future<ProfileResponse> getProfile(String userId) async {
    String loggedUser = await _authPrefsHelper.getUserId();

    dynamic response = await _apiClient.get(Urls.API_PROFILE + userId);
    if (response == null) return null;
    ProfileResponse result = ProfileResponse.fromJson(response['Data']);

    if(userId != loggedUser ){
      await Future.wait([
        _getPreviousComments(userId),
        _getWatchedSeries(userId),
        _getFollowingNumber(userId,loggedUser),
      ]) ;

    }else{
      await Future.wait([
        _getFollowingActivities(userId),
        _getWatchedSeries(userId),
        _getFollowingNumber(userId,loggedUser),
      ]) ;

    }

    result.followingActivitiesResponse = followingActivitiesResponse1;
    result.previousCommentsResponse = previousCommentsResponse1;
    result.favourites = favourites1;
    result.followingNumber = followingNumber1;
    result.isFollowed = isFollowed1;

    return result;
  }

  Future<void> _getFollowingNumber(String userId,String friendId) async {
    dynamic response = await _apiClient.get(Urls.API_FOLLOWING_USERS + userId);
    if (response == null) return 0;

    dynamic res = response['Data'];
    followingNumber1 = res.length;

    await  _isFollowed(res,friendId);
  }

  Future<void> _isFollowed(dynamic res , String friendId) async {

    for (int i = 0; i < res.length; i++) {
      FollowingUsersResponse follow = FollowingUsersResponse.fromJson(res[i]);
      if (friendId == follow.friendID) isFollowed1 =  true;
    }

  }

  Future<void> _getFollowingActivities(
      String userId) async {
    dynamic response =
    await _apiClient.get(Urls.API_FOLLOWING_ACTIVITIES + userId);
    if (response == null) return [];
    List<FollowingActivitiesResponse> result = [];
    dynamic res = response['Data'];

    for (int i = 0; i < res.length; i++) {
      result.add(FollowingActivitiesResponse.fromJson(res[i]));
    }
    followingActivitiesResponse1 = result;
  }

  Future<void> _getWatchedSeries(String userId) async {
    dynamic response =
    await _apiClient.get(Urls.API_FAVOURITE_ANIMES + '$userId');

    if (response == null) return [];

    List<FavouriteResponse> series = [];
    dynamic res = response['Data'];
    for (int i = 0; i < res.length; i++) {
      series.add(FavouriteResponse.fromJson(res[i]));
    }

    favourites1 = series;
  }

  Future<void> _getPreviousComments(String userId) async{
    dynamic response = await _apiClient.get(Urls.API_PREVIOUS_COMMENTS+userId);
    if (response == null ) return null;
    previousCommentsResponse1 = PreviousCommentsResponse.fromJson(response['Data']);
  }

  Future<bool> follow(String userId, String friendId) async {
    dynamic response = await _apiClient
        .post(Urls.API_FOLLOW, {'userID': userId, 'friendID': friendId});

    return response == null
        ? null
        : response['status_code'] == '201'
        ? true
        : false;
  }

  Future<bool> unFollow(String userId, String friendId) async {
    dynamic response =
    await _apiClient.delete(Urls.API_FOLLOW + '/$userId/$friendId');
    return response == null
        ? null
        : response['status_code'] == '401'
        ? true
        : false;
  }


  Future<ProfileResponse> getMyProfile() async {
    Map<String, dynamic> response = await _apiClient.get(Urls.API_PROFILE);

    return response ?? ProfileResponse.fromJson(response);
  }

  Future<ProfileResponse> createMyProfile(
      CreateProfileRequest profileRequest) async {
    Map<String, dynamic> response = await _apiClient.post(
        Urls.API_PROFILE.substring(0, Urls.API_PROFILE.length - 1),
        profileRequest.toJson());

    return response == null ? null : ProfileResponse.fromJson(response);
  }

  Future<ProfileResponse> updateMyProfile(
      CreateProfileRequest profileRequest) async {
    Map<String, dynamic> response = await _apiClient.put(
        Urls.API_PROFILE.substring(0, Urls.API_PROFILE.length - 1),
        profileRequest.toJson());

    return response == null ? null : ProfileResponse.fromJson(response);
  }
}
