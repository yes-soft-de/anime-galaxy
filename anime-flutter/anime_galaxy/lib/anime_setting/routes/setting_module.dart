

import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/anime_setting/routes/setting_route.dart';
import 'package:anime_galaxy/anime_setting/ui/screen/anim_setting.dart';
import 'package:anime_galaxy/module_settings/ui/ui/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SettingModule extends YesModule{
  final AnimSetting _animSetting;

  SettingModule(this._animSetting);


  @override
  Map<String, WidgetBuilder> getRoutes(){
    return {
      SettingRoutes.ROUTE_SETTING_PAGE: (context)=> _animSetting,
    };
  }
}