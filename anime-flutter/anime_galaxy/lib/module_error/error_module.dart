import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_error/error_routes.dart';
import 'package:anime_galaxy/module_error/ui/screen/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ErrorModule extends YesModule {
  final ErrorScreen _errorScreen;

  ErrorModule(this._errorScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {ErrorRoutes.ROUTE_ERROR: (context) => _errorScreen};
  }
}
