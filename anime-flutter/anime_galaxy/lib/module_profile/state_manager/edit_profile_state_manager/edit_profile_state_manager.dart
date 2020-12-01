import 'dart:io';

import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_profile/service/my_profile/my_profile.dart';
import 'package:anime_galaxy/module_upload/service/image_upload/image_upload_service.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class EditProfileStateManager {
  final PublishSubject<String> stateStream = PublishSubject();
  final MyProfileService _myProfileService;
  final ImageUploadService _imageUploadService;

  EditProfileStateManager(this._myProfileService ,this._imageUploadService);

  void saveProfileImage(String path) {
    _myProfileService.saveImage(path);
  }

  void uploadImage(String userImage){
    _imageUploadService.uploadImage(userImage).then((value) {
      if (value != null) {
            saveProfileImage(Urls.BASE_API+'/'+value);
            stateStream.add(value);
      } else {
//        imageurl = null;
      }
    });
  }
  void saveProfile(String name, String story, String userImage) {

    _myProfileService.createProfile(name, userImage, story).then((value) {
      if (value != null) {
        stateStream.add(null);
      } else {
        stateStream.add('Cant create a profile');
      }
    });
  }
}
