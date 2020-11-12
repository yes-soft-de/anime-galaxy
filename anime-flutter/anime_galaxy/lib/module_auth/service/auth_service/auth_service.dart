import 'package:anime_galaxy/module_auth/enums/auth_source.dart';
import 'package:anime_galaxy/module_auth/manager/auth/auth_manager.dart';
import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
import 'package:anime_galaxy/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:anime_galaxy/module_profile/request/create_profile.dart';
import 'package:anime_galaxy/utils/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';

@provide
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
  final MyProfileManager _profileManager;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthService(
    this._prefsHelper,
    this._authManager,
    this._profileManager,
  );

  Future<bool> loginUser(
      String uid, String name, String email, AUTH_SOURCE authSource,
      [String image]) async {
    try {
      await _authManager.createUser(uid);
      await _createProfile(
        uid,
        name,
        email,
        image,
      );
    } catch (e) {
      Logger().info('AuthService', 'User Already Exists');
    }

    String token = await _authManager.getToken(uid, uid);

    if (token == null) {
      return false;
    }
    await _prefsHelper.setUserId(uid);
    await _prefsHelper.setUsername(name);
    await _prefsHelper.setAuthSource(authSource);
    await _prefsHelper.setToken(token);
    return true;
  }

  Future<void> _createProfile(
      String uid, String name, String email, String image) async {
    String userId = await userID;

    CreateProfileRequest request = CreateProfileRequest(
        userName: name,
        image: image,
        location: 'Saudi Arabia',
        story: ' ',
        userID: userId);

    await _profileManager.createMyProfile(request);
  }

  Future<String> getToken() async {
    bool isLoggedIn = await this.isLoggedIn;
    if (isLoggedIn) {
      await refreshToken();
      return _prefsHelper.getToken();
    }

    return null;
  }

  Future<void> refreshToken() async {
    String uid = await _prefsHelper.getUserId();
    String token = await _authManager.getToken(uid, uid);
    await _prefsHelper.setToken(token);
  }

  Future<bool> get isLoggedIn => _prefsHelper.isSignedIn();

  Future<String> get userID => _prefsHelper.getUserId();

  Future<String> get username => _prefsHelper.getUsername();

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _prefsHelper.clearPrefs();
  }
}
