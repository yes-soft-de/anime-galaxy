import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_auth/auth_routes.dart';
import 'package:anime_galaxy/module_auth/ui/screen/auth_screen/auth_screen.dart';
import 'package:anime_galaxy/module_auth/ui/screen/forgot_password_screen/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class AuthModule extends YesModule {
  final AuthScreen _authScreen;
  final ForgotPasswordScreen _forgotPasswordScreen;
  AuthModule(
      this._authScreen,
      this._forgotPasswordScreen,
      );

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      AuthRoutes.ROUTE_AUTHORIZE: (context) => _authScreen,
      AuthRoutes.FORGOT_PASSWORD_SCREEN: (context) => _forgotPasswordScreen,
    };

  }
}
