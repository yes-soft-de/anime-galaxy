import 'package:anime_galaxy/module_auth/enums/auth_source.dart';
import 'package:anime_galaxy/module_auth/manager/auth/auth_manager.dart';
import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
import 'package:anime_galaxy/utils/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final PublishSubject<String> authServiceStateSubject = PublishSubject();

  AuthService(
      this._prefsHelper,
      this._authManager,
      );

  Future<String> loginUser(
      String uid, String name, String email, AUTH_SOURCE authSource,
      [String image]) async {
    authServiceStateSubject.add('User is Verified, Creating a user in our DB');
    var userExists = false;

    try {
      var token = await _authManager.getToken(uid, uid);
      userExists = token != null;
    } catch (e) {
      Logger().info('Auth Service', e);
    }

    try {
      if (!userExists) await _authManager.createUser(uid);

    } catch (e) {
      Logger().info('AuthService', 'User Already Exists');
    }

    await _prefsHelper.setUserId(uid);
    await _prefsHelper.setUsername(name);
    await _prefsHelper.setAuthSource(authSource);
    await _prefsHelper.setToken(uid);

    return userExists?'registered':'notRegistered';
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

  Future<bool> get isLoggedIn async {
    var user = await _firebaseAuth.currentUser;
    var savedLogin = await _prefsHelper.isSignedIn();

    return user != null && savedLogin;
  }

  Future<String> get userID => _prefsHelper.getUserId();

  Future<String> get username => _prefsHelper.getUsername();

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _prefsHelper.clearPrefs();
  }
}
