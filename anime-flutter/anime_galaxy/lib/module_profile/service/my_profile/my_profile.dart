import 'package:anime_galaxy/module_anime/response/favourite_response/favourite_response.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:anime_galaxy/module_profile/model/profile_model/profile_model.dart';
import 'package:anime_galaxy/module_profile/presistance/profile_shared_preferences.dart';
import 'package:anime_galaxy/module_profile/request/create_profile.dart';
import 'package:anime_galaxy/module_profile/response/following_activities_response/following_activities_response.dart';
import 'package:anime_galaxy/module_profile/response/profile_response/profile_response.dart';
import 'package:anime_galaxy/module_profile/service/general_profile/general_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';

@provide
class MyProfileService {
  final MyProfileManager _manager;
  final ProfileSharedPreferencesHelper _preferencesHelper;
  final AuthService _authService;
  final GeneralProfileService _generalProfileService;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  MyProfileService(
      this._manager,
      this._preferencesHelper,
      this._authService,
      this._generalProfileService,
      );

  Future<ProfileModel> getProfile({String id}) async {
    String userId = id ?? await _authService.userID;

    ProfileResponse response = await _manager.getProfile(userId);
    if (response != null) {
      ProfileModel result = new ProfileModel(
        name: response.userName,
        image: response.image,
        followingNumber: response.followingNumber,
        about: response.story,
        seriesNumber: response.favourites.length,
        watchedSeries: _getSeries(response.favourites),
        followingActivities:
        _getActivities(response.followingActivitiesResponse),
        isFollowed: response.isFollowed,
      );
      return result;
    }
    return null;
  }

  Future<bool> follow(String friendId) async {
    String userId = await _authService.userID;

    return await _manager.follow(userId, friendId);
  }

  Future<bool> unFollow(String friendId) async {
    String userId = await _authService.userID;

    return await _manager.unFollow(userId, friendId);
  }

  List<Activity> _getActivities(
      List<FollowingActivitiesResponse> followingActivitiesResponse) {
    List<Activity> activities = [];

    followingActivitiesResponse.forEach((element) {
      activities.add(new Activity(
        userName: element.userName,
        action: element.animeName,
      ));
    });
    return activities;
  }

  List<Series> _getSeries(List<FavouriteResponse> favouriteResponses) {
    List<Series> seriesList = [];

    favouriteResponses.forEach((element) {
      seriesList.add(new Series(
          id: element.animeID,
          name: element.animeName,
          image: element.mainImage,
          classification: ' '));
    });
    return seriesList;
  }

  Future<bool> hasProfile() async {
    String userImage = await _preferencesHelper.getImage();
    return userImage != null;
  }

  Future<ProfileModel> get profile async {
    var username = await _preferencesHelper.getUsername();
    return ProfileModel(
      name: username,
    );
  }

  Future<ProfileResponse> createProfile(
      String username,
      String userImage,
      String story,
      ) async {
    String userId = await _authService.userID;

    var profileExists = await _manager.getProfile(userId);

    CreateProfileRequest request = CreateProfileRequest(
        userName: username,
        image: userImage,
        location: 'Saudi Arabia',
        story: story,
        userID: userId);


    ProfileResponse response = (profileExists == null)
        ? await _manager.createMyProfile(request)
        :await _manager.updateMyProfile(request);
    if (response == null) return null;
    await _preferencesHelper.setUserName(response.userName);
    await _preferencesHelper.setUserImage(response.image);
    await _preferencesHelper.setUserLocation(response.location);
    await _preferencesHelper.setUserStory(response.story);
    await _generalProfileService.setUserProfile(
        userId,
        ProfileModel(
          name: response.userName,
          image: response.image,
        ));
    return response;
  }
}
