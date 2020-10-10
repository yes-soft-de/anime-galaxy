import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_forms/forms_routes.dart';

@provide
class FormsModule extends YesModule {

  FormsModule();

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {};
  }
}
