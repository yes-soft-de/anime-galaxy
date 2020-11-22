import 'package:anime_galaxy/main_screen/main_screen_module.dart';
import 'package:anime_galaxy/main_screen/main_screen_routes.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_error/error_module.dart';
import 'package:anime_galaxy/module_home/home.module.dart';
import 'package:anime_galaxy/module_init_account/account_module.dart';
import 'package:anime_galaxy/module_notification/notification_module.dart';
import 'package:anime_galaxy/utils/logger/logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';

import 'anime_setting/routes/setting_module.dart';
import 'camera/camera_module.dart';
import 'di/components/app.component.dart';
import 'generated/l10n.dart';
import 'module_anime/anime_module.dart';
import 'module_auth/auth_module.dart';
import 'module_chat/chat_module.dart';
import 'module_episode/episode_module.dart';
import 'module_explore/explore_module.dart';
import 'module_localization/service/localization_service/localization_service.dart';
import 'module_profile/profile_module.dart';
import 'module_settings/setting_module.dart';
import 'module_theme/service/theme_service/theme_service.dart';

typedef Provider<T> = T Function();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    final container = await AppComponent.create();
    runApp(container.app);
  });
}

@provide
class MyApp extends StatefulWidget {
  final ChatModule _chatModule;
  final CameraModule _cameraModule;
  final AuthModule _authModule;
  final AuthService _authService;
  final ProfileModule _profileModule;
  final LocalizationService _localizationService;
  final SwapThemeDataService _swapThemeService;
  final HomeModule _homeModule;
  final AnimeModule _animeModule;
  final NotificationModule _notificationModule;
  final AccountModule _accountModule;
  final MainScreenModule _mainScreenModule;
  final SettingModule _settingModule;
  final ExploreModule _exploreModule;
  final EpisodeModule _episodeModule;
  final ErrorModule _errorModule;

  MyApp(
    this._chatModule,
    this._cameraModule,
    this._authModule,
    this._errorModule,
    this._profileModule,
    this._localizationService,
    this._swapThemeService,
    this._authService,
    this._homeModule,
    this._animeModule,
    this._notificationModule,
    this._accountModule,
    this._mainScreenModule,
    this._settingModule,
    this._exploreModule,
    this._episodeModule,
  );

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  String lang;
  bool isDarkMode;
  bool authorized = false;

  @override
  void initState() {
    super.initState();

    widget._localizationService.localizationStream.listen((event) {
      lang = event;
      setState(() {});
    });

    widget._swapThemeService.darkModeStream.listen((event) {
      isDarkMode = event;
      Logger().info('Main.dart', 'Dark Mode: ' + isDarkMode.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> fullRoutesList = {};

    fullRoutesList.addAll(widget._chatModule.getRoutes());
    fullRoutesList.addAll(widget._authModule.getRoutes());
    fullRoutesList.addAll(widget._cameraModule.getRoutes());
    fullRoutesList.addAll(widget._profileModule.getRoutes());
    fullRoutesList.addAll(widget._homeModule.getRoutes());
    fullRoutesList.addAll(widget._animeModule.getRoutes());
    fullRoutesList.addAll(widget._notificationModule.getRoutes());
    fullRoutesList.addAll(widget._accountModule.getRoutes());
    fullRoutesList.addAll(widget._mainScreenModule.getRoutes());
    fullRoutesList.addAll(widget._settingModule.getRoutes());
    fullRoutesList.addAll(widget._exploreModule.getRoutes());
    fullRoutesList.addAll(widget._episodeModule.getRoutes());
    fullRoutesList.addAll(widget._errorModule.getRoutes());

    return FutureBuilder(
      future: getConfiguratedApp(fullRoutesList),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) return snapshot.data;
        return Scaffold();
      },
    );
  }

  Future<Widget> getConfiguratedApp(
      Map<String, WidgetBuilder> fullRoutesList) async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    lang ??= await widget._localizationService.getLanguage();
    isDarkMode ??= await widget._swapThemeService.isDarkMode();
    authorized ??= await widget._authService.isLoggedIn;
    Logger().info('main.dart', isDarkMode.toString());

    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      locale: Locale.fromSubtags(
        languageCode: 'ar' /* lang ?? 'en'*/,
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: isDarkMode == true
          ? ThemeData(
              brightness: Brightness.dark,
            )
          : ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.white,
            ),
      supportedLocales: S.delegate.supportedLocales,
      title: 'Anime Galaxy',
      routes: fullRoutesList,
      initialRoute: MainScreenRoute.MAIN_SCREEN_ROUTE,
    );
  }
}
