import 'package:anime_galaxy/generated/l10n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:anime_galaxy/module_profile/service/my_profile/my_profile.dart';
import 'package:anime_galaxy/module_profile/state/my_profile_state.dart';
import 'package:anime_galaxy/module_upload/service/image_upload/image_upload_service.dart';

@provide
class MyProfileStateManager {
  final PublishSubject<MyProfileState> _stateSubject = PublishSubject();

  Stream<MyProfileState> get stateStream => _stateSubject.stream;

  final ImageUploadService _uploadService;
  final MyProfileService _myProfileService;

  MyProfileStateManager(this._uploadService, this._myProfileService);

  void getMyProfile(){
     _stateSubject.add(ProfileFetchingData());
     _myProfileService.getProfile().then((value) {
       if(value == null){
           Fluttertoast.showToast(msg: S.current.errorHappened);
           _stateSubject.add(ProfileFetchingDataError());
       }else{
         _stateSubject.add(ProfileFetchingDataSuccess(value));
       }
     });
  }



  void setMyProfile(String username, String about, String image) {
    _myProfileService.createProfile(username, image, about).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: 'Error Submitting Profile');
      } else {
        _stateSubject.add(MyProfileStateUpdateSuccess());
      }
    });
  }

  void upload(String imagePath) {
    this._uploadService.uploadImage(imagePath).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: 'Error Uploading Image');
      } else {
        _stateSubject.add(MyProfileStateImageUploadSuccess(value));
      }
    });
  }
}
