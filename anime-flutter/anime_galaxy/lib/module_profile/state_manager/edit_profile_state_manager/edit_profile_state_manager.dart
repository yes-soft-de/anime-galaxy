import 'package:anime_galaxy/module_profile/service/my_profile/my_profile.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class EditProfileStateManager {
  final PublishSubject<String> stateStream = PublishSubject();
  final MyProfileService _myProfileService;

  EditProfileStateManager(this._myProfileService);

  void saveProfileImage(String path) {
    _myProfileService.saveImage(path);
  }

  void saveProfile(String name, String story) {
    _myProfileService.createProfile(name, null, story).then((value) {
      if (value != null) {
        stateStream.add(null);
      } else {
        stateStream.add('Cant create a profile');
      }
    });
  }
}
