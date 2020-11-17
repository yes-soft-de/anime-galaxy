import 'package:anime_galaxy/module_profile/repository/my_profile/my_profile.repository.dart';
import 'package:anime_galaxy/module_profile/request/create_profile.dart';
import 'package:anime_galaxy/module_profile/response/profile_response/profile_response.dart';
import 'package:inject/inject.dart';

@provide
class MyProfileManager {
  final MyProfileRepository _repository;
  MyProfileManager(this._repository);

  Future<ProfileResponse> getProfile(String userId) async {
    return await _repository.getProfile(userId);
  }

  Future<bool> follow(String userId, String friendId) async {
    return await _repository.follow(userId, friendId);
  }

  Future<bool> unFollow(String userId, String friendId) async {
    return await _repository.unFollow(userId, friendId);
  }

  Future<ProfileResponse> getMyProfile() {
    return _repository.getMyProfile();
  }

  Future<ProfileResponse> createMyProfile(
      CreateProfileRequest createProfileRequest) async {
    return await _repository.createMyProfile(createProfileRequest);
  }

  Future<ProfileResponse> updateMyProfile(
      CreateProfileRequest createProfileRequest) async {
    return await _repository.updateMyProfile(createProfileRequest);
  }
}
