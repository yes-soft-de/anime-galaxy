import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_profile/presistance/profile_shared_preferences.dart';
import 'package:anime_galaxy/module_profile/service/my_profile/my_profile.dart';

@provide
class ProfileScreen extends StatefulWidget {
  final AuthService _authService;
  final MyProfileService _myProfileService;
  final ProfileSharedPreferencesHelper _preferencesHelper;

  ProfileScreen(
    this._authService,
    this._myProfileService,
    this._preferencesHelper,
  );

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool hasProfile = false;
  @override
  void initState() {
    super.initState();
    // Listent to Events Here
  }

  @override
  Widget build(BuildContext context) {
    return getUI(hasProfile);
  }

  Widget getUI(bool hasProfile) {
    return Scaffold();
  }
}
