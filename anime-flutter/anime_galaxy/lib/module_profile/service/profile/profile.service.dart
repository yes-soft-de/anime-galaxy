

import 'package:anime_galaxy/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:anime_galaxy/module_profile/model/profile_model/profile_model.dart';
import 'package:anime_galaxy/module_profile/response/profile_response/profile_response.dart';
import 'package:inject/inject.dart';

@provide
class ProfileService {
 MyProfileManager _profileManager;
 ProfileService(this._profileManager);

    Future<ProfileModel> getProfile(String userId)async{
     ProfileResponse response = await _profileManager.getProfile(userId);
     if(response == null) return null;

     ProfileModel profile = new ProfileModel(
      name: response.data.userName,
      image: response.data.userName,

     );

    }

}