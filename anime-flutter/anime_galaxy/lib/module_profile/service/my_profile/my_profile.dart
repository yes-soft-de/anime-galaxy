import 'package:anime_galaxy/module_anime/response/favourite_response/favourite_response.dart';
import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
import 'package:anime_galaxy/module_profile/response/following_activities_response/following_activities_response.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:anime_galaxy/module_profile/model/profile_model/profile_model.dart';
import 'package:anime_galaxy/module_profile/presistance/profile_shared_preferences.dart';
import 'package:anime_galaxy/module_profile/request/create_profile.dart';
import 'package:anime_galaxy/module_profile/response/profile_response/profile_response.dart';
import 'package:anime_galaxy/module_profile/service/general_profile/general_profile.dart';

@provide
class MyProfileService {
  final MyProfileManager _manager;
  final ProfileSharedPreferencesHelper _preferencesHelper;
  final AuthService _authService;
  final GeneralProfileService _generalProfileService;
  final  AuthPrefsHelper _authPrefsHelper;

  MyProfileService(
    this._manager,
    this._preferencesHelper,
    this._authService,
    this._generalProfileService,
    this._authPrefsHelper,
  );

  Future<ProfileModel> getProfile()async{
    String userId = await _authPrefsHelper.getUserId();
    ProfileResponse response = await _manager.getProfile(userId);
    ProfileModel result = new ProfileModel(
      name: response.data.userName,
      image: response.data.image,
      followingNumber: response.followingNumber,
      about: response.data.story,
      seriesNumber: response.favourites.length,
      watchedSeries: _getSeries(response.favourites),
      followingActivities: _getActivities(response.followingActivitiesResponse),
    );
  }

  List<Activity>   _getActivities(List<FollowingActivitiesResponse> followingActivitiesResponse){
    List<Activity> activities =[];

    followingActivitiesResponse.forEach((element) {

      activities.add(
          new Activity(
              userName: element.userName,
            action: element.animeName,
          )
      );
    });
    return activities;

  }

  List<Series> _getSeries(List<FavouriteResponse> favouriteResponses){
    List<Series> seriesList =[];

    favouriteResponses.forEach((element) {

      seriesList.add(
          new Series(
              id: element.id,
              name: element.animeName,
              image :element.mainImage,
              //TODO : change this to real data
              classification: 'شاونين'
          )
      );
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

    CreateProfileRequest request = CreateProfileRequest(
        userName: username,
        image: userImage,
        location: 'Saudi Arabia',
        story: story,
        userID: userId);

    ProfileResponse response = await _manager.createMyProfile(request);
    if (response == null) return null;
    await _preferencesHelper.setUserName(response.data.userName);
    await _preferencesHelper.setUserImage(response.data.image);
    await _preferencesHelper.setUserLocation(response.data.location);
    await _preferencesHelper.setUserStory(response.data.story);
    await _generalProfileService.setUserProfile(
        userId,
        ProfileModel(
          name: response.data.userName,
          image: response.data.image,
        ));
    return response;
  }
}
