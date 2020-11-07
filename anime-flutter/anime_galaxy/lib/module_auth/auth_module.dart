
import 'package:anime_galaxy/module_auth/ui/screen/sign_in_and_sign_up/sign_in_and_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_auth/auth_routes.dart';
import 'package:anime_galaxy/module_auth/ui/screen/auth_screen/auth_screen.dart';

@provide
class AuthModule extends YesModule {
  final AuthScreen _authScreen;
  final LoginRegisterScreen _loginRegisterScreen;

  AuthModule(
  this._authScreen,
  this._loginRegisterScreen,
  );

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      AuthRoutes.ROUTE_AUTHORIZE: (context) => _authScreen,
      AuthRoutes.ROUTE_LOGIN: (context) => _loginRegisterScreen,

    };
  }
}
