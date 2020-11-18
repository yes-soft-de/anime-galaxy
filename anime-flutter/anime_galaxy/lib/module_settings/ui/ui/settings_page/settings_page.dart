import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/main_screen/main_screen_routes.dart';
import 'package:anime_galaxy/module_auth/auth_routes.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_localization/service/localization_service/localization_service.dart';
import 'package:anime_galaxy/module_theme/service/theme_service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SettingsPage extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;
  final SwapThemeDataService _themeDataService;

  SettingsPage(
      this._authService,
      this._localizationService,
      this._themeDataService,
      );

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.black12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).username),
                  FutureBuilder(
                    future: widget._authService.username,
                    builder: (
                        BuildContext context,
                        AsyncSnapshot<String> snapshot,
                        ) {
                      return Text(snapshot.data ?? S.of(context).notLoggedIn);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.black12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).darkMode),
                  StreamBuilder(
                    stream: widget._themeDataService.darkModeStream,
                    initialData: false,
                    builder: (
                        BuildContext context,
                        AsyncSnapshot<bool> snapshot,
                        ) {
                      return Switch(
                          value:
                          Theme.of(context).brightness == Brightness.dark,
                          onChanged: (mode) {
                            widget._themeDataService
                                .switchDarkMode(mode)
                                .then((value) {});
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.black12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: widget._authService.isLoggedIn,
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data) {
                    return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).signOut),
                        IconButton(
                            icon: Icon(Icons.power_settings_new),
//                             icon: Icon(Icons.arrow_drop_down_circle),
                            onPressed: () {
                              widget._authService.logout().then((value) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  MainScreenRoute.MAIN_SCREEN_ROUTE,
                                      (route) => false,
                                );
                              });
                            })
                      ],
                    );
                  } else {
                    return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).login),
                        IconButton(
//                            icon: Icon(Icons.login),
                            icon: Icon(Icons.radio),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AuthRoutes.ROUTE_AUTHORIZE);
                            })
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
