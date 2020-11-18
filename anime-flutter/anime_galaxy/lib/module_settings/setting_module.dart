import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_settings/setting_routes.dart';
import 'package:anime_galaxy/module_settings/ui/ui/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SettingModule extends YesModule{
  final SettingsPage _settingsPage;

  SettingModule(this._settingsPage);

  @override
  Map<String,WidgetBuilder> getRoutes() {
    return{
      SettingRoutes.SETTING_SCREEN_ROUTE : (context) => _settingsPage,
    };
  }

}