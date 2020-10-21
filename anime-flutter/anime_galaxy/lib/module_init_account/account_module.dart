import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_init_account/init_account_routes.dart';
import 'package:anime_galaxy/module_init_account/ui/screen/init_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class AccountModule extends YesModule{
  final InitAccountScreen _accountScreen;

  AccountModule(this._accountScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      InitAccountRoutes.INIT_ACCOUNT_ROUTE :(context) => _accountScreen,
    };
  }


}