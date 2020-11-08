import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anime_galaxy/module_auth/enums/auth_source.dart';

@provide
class AuthPrefsHelper {
  Future<void> setUserId(String userId) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    await preferencesHelper.setString('uid', userId);
    return;
  }

  Future<String> getUserId() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.getString('uid');
  }

  Future<void> setUsername(String username) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.setString('username', username);
  }

  Future<String> getUsername() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.getString('username');
  }

  Future<bool> isSignedIn() async {
    String uid = await getToken();
    if (uid == null) {
      return false;
    }
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    String date = await preferencesHelper.getString('token_date');
    if (DateTime.parse(date).difference(DateTime.now()).inMinutes > 50) {
      return false;
    }
    return true;
  }

  Future<AUTH_SOURCE> getAuthSource() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.getInt('auth_source') as AUTH_SOURCE;
  }

  Future<void> setAuthSource(AUTH_SOURCE authSource) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.setInt(
      'auth_source',
      authSource == null ? null : authSource.index,
    );
  }

  Future<void> setToken(String token) async {
    if (token == null) {
      return;
    }
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    await preferencesHelper.setString(
      'token',
      token,
    );
    await preferencesHelper.setString(
        'token_date', DateTime.now().toIso8601String());
  }

  Future<String> getToken() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    var tokenDateString = preferencesHelper.getString('token_date');
    if (tokenDateString == null) {
      return null;
    }
    if (DateTime.parse(tokenDateString).difference(DateTime.now()) >
        Duration(minutes: 55)) {
      await preferencesHelper.remove('token');
      await preferencesHelper.remove('token_date');
      return null;
    }
    return preferencesHelper.getString('token');
  }

  Future<void> clearPrefs() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    await preferencesHelper.clear();
  }
}
