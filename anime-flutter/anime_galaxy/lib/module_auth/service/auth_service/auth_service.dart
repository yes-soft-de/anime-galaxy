import 'package:anime_galaxy/module_auth/enums/auth_source.dart';
import 'package:anime_galaxy/module_auth/manager/auth/auth_manager.dart';
import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
import 'package:anime_galaxy/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:anime_galaxy/module_profile/request/create_profile.dart';
import 'package:anime_galaxy/utils/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
  final MyProfileManager _profileManager;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final PublishSubject<String> authServiceStateSubject = PublishSubject();

  AuthService(
    this._prefsHelper,
    this._authManager,
    this._profileManager,
  );

  Future<bool> loginUser(
      String uid, String name, String email, AUTH_SOURCE authSource,
      [String image]) async {
    authServiceStateSubject.add('User is Verified, Creating a user in our DB');
    try {
      await _authManager.createUser(uid);
    } catch (e) {
      Logger().info('AuthService', 'User Already Exists');
    }
    await _createProfile(
      uid,
      name,
      email,
      image,
    );

    await _prefsHelper.setUserId(uid);
    await _prefsHelper.setUsername(name);
    await _prefsHelper.setAuthSource(authSource);
    return true;
  }

  Future<void> _createProfile(
      String uid, String name, String email, String image) async {
    authServiceStateSubject
        .add('User is Created, Starting a new profile for you');
    String userId = await userID;

    var profile = await _profileManager.createMyProfile(CreateProfileRequest(
      userName: name ?? ' ',
      image: null,
      location: 'Saudi Arabia',
      story: ' ',
      userID: userId,
    ));

    if (profile == null) {
      authServiceStateSubject.add('Error Creating Profile');
      Logger().error('Auth Error', 'Error Creating Profile');
      FirebaseCrashlytics.instance.crash();
    }
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
