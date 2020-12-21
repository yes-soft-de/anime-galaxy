import 'package:anime_galaxy/module_profile/model/profile_model/profile_model.dart';

class MyProfileState {}

class MyProfileStateInit extends MyProfileState {}

class MyProfileStateUpdateSuccess extends MyProfileState {}

class MyProfileStateCreateSuccess extends MyProfileState {}

class MyProfileStateImageUploadSuccess extends MyProfileState {
  String imageUrl;

  MyProfileStateImageUploadSuccess(this.imageUrl);
}

class MyProfileStateUpdateError extends MyProfileState {}

///-------------------------------------------
class ProfileFetchingData extends MyProfileState{}

class ProfileFetchingDataSuccess extends MyProfileState{
  ProfileModel data;

  ProfileFetchingDataSuccess(this.data);
}

class ProfileFetchingDataError extends MyProfileState{}
///-------------------------------------------
class ProfileFollowSuccess extends MyProfileState{}

class ProfileFollowError extends MyProfileState{}
///-------------------------------------------
class ProfileUnFollowSuccess extends MyProfileState{}

class ProfileUnFollowError extends MyProfileState{}
///-------------------------------------------
class ProfileUploadImageSuccess extends MyProfileState{
  String data;
  ProfileUploadImageSuccess(this.data);
}

class ProfileUploadImageError extends MyProfileState{}