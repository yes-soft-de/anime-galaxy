import 'package:inject/inject.dart';
import 'package:anime_galaxy/module_profile/repository/my_profile/my_profile.dart';
import 'package:anime_galaxy/module_profile/request/create_profile.dart';
import 'package:anime_galaxy/module_profile/response/profile_response/profile_response.dart';

@provide
class MyProfileManager {
  final MyProfileRepository _repository;
  MyProfileManager(this._repository);

  Future<ProfileResponse> getProfile(String userId) {
    return _repository.getProfile(userId);
  }

//  Future<ProfileResponse> createMyProfile(
//      CreateProfileRequest createProfileRequest) {
//    return _repository.createMyProfile(createProfileRequest);
//  }
}
