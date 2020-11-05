import 'app.component.dart' as _i1;
import '../../utils/auth_guard/auth_gard.dart' as _i2;
import '../../utils/logger/logger.dart' as _i3;
import '../../module_localization/service/localization_service/localization_service.dart'
    as _i4;
import 'dart:async' as _i5;
import '../../main.dart' as _i6;
import '../../module_chat/chat_module.dart' as _i7;
import '../../module_chat/ui/screens/chat_page/chat_page.dart' as _i8;
import '../../module_chat/bloc/chat_page/chat_page.bloc.dart' as _i9;
import '../../module_chat/service/chat/char_service.dart' as _i10;
import '../../module_chat/manager/chat/chat_manager.dart' as _i11;
import '../../module_chat/repository/chat/chat_repository.dart' as _i12;
import '../../module_persistence/sharedpref/shared_preferences_helper.dart'
    as _i13;
import '../../camera/camera_module.dart' as _i14;
import '../../camera/ui/screen/camera_screen/camera_screen.dart' as _i15;
import '../../module_auth/auth_module.dart' as _i16;
import '../../module_auth/ui/screen/auth_screen/auth_screen.dart' as _i17;
import '../../module_auth/state_manager/auth_state_manager/auth_state_manager.dart'
    as _i18;
import '../../module_auth/service/auth_service/auth_service.dart' as _i19;
import '../../module_auth/presistance/auth_prefs_helper.dart' as _i20;
import '../../module_auth/manager/auth/auth_manager.dart' as _i21;
import '../../module_auth/repository/auth/auth_repository.dart' as _i22;
import '../../module_network/http_client/http_client.dart' as _i23;
import '../../module_profile/profile_module.dart' as _i24;
import '../../module_profile/ui/my_profile/my_profile.dart' as _i25;
import '../../module_profile/state_manager/my_profile/my_profile_state_manager.dart'
    as _i26;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i27;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i28;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i29;
import '../../module_profile/service/my_profile/my_profile.dart' as _i30;
import '../../module_profile/manager/my_profile_manager/my_profile_manager.dart'
    as _i31;
import '../../module_profile/repository/my_profile/my_profile.dart' as _i32;
import '../../module_profile/presistance/profile_shared_preferences.dart'
    as _i33;
import '../../module_profile/service/general_profile/general_profile.dart'
    as _i34;
import '../../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i35;
import '../../module_theme/service/theme_service/theme_service.dart' as _i36;
import '../../module_theme/pressistance/theme_preferences_helper.dart' as _i37;
import '../../module_home/home.module.dart' as _i38;
import '../../module_home/ui/screens/home_screen.dart' as _i39;
import '../../module_home/state_manager/home/home.state_manager.dart' as _i40;
import '../../module_home/service/home/home.service.dart' as _i41;
import '../../module_home/manager/home/home.manager.dart' as _i42;
import '../../module_home/repository/home/home.repository.dart' as _i43;
import '../../module_anime/anime_module.dart' as _i44;
import '../../module_anime/ui/screen/anime_details_screen/anime_details_screen.dart'
    as _i45;
import '../../module_anime/state_manager/anime_details/anime_details.state_manager.dart'
    as _i46;
import '../../module_anime/service/anime_details/anime_details.service.dart'
    as _i47;
import '../../module_anime/manager/anime_details/anime_details.manager.dart'
    as _i48;
import '../../module_anime/repository/anime_details/anime_details.repository.dart'
    as _i49;
import '../../module_notification/notification_module.dart' as _i50;
import '../../module_notification/ui/screen/notification_screen/notification_screen.dart'
    as _i51;
import '../../module_notification/state_manager/notification/notification.state_manager.dart'
    as _i52;
import '../../module_notification/service/notification/notification.service.dart'
    as _i53;
import '../../module_notification/manager/notification/notification.manager.dart'
    as _i54;
import '../../module_notification/repository/notification/notification.repository.dart'
    as _i55;
import '../../module_init_account/account_module.dart' as _i56;
import '../../module_init_account/ui/screen/init_account_screen.dart' as _i57;
import '../../module_init_account/state_manager/init_account/init_account.state_manager.dart'
    as _i58;
import '../../module_init_account/service/init_account/init_account.service.dart'
    as _i59;
import '../../module_init_account/manager/init_account/init_account.manager.dart'
    as _i60;
import '../../module_init_account/repository/init_account/init_account.repository.dart'

    as _i61;
import '../../main_screen/main_screen_module.dart' as _i62;
import '../../main_screen/ui/screen/main_screen.dart' as _i63;
import '../../module_settings/ui/ui/settings_page/settings_page.dart' as _i64;
import '../../module_explore/ui/screen/explore_screen/explore_screen.dart'
    as _i65;
import '../../module_explore/state_manager/explore/explore.state_manager.dart'
    as _i66;
import '../../module_explore/service/explore/explore.service.dart' as _i67;
import '../../module_explore/manager/explore/explore.manager.dart' as _i68;
import '../../module_explore/repository/explore/explore.repositry.dart' as _i69;
import '../../anime_setting/routes/setting_module.dart' as _i70;
import '../../anime_setting/ui/screen/anim_setting.dart' as _i71;
import '../../anime_setting/ui/style_app.dart' as _i72;
import '../../anime_auth/auth_module.dart' as _i73;
import '../../anime_auth/ui/screen/sign_up/sign_up.dart' as _i74;
import '../../anime_auth/style_auth.dart' as _i75;
import '../../anime_auth/ui/screen/sign_in/sign_in.dart' as _i76;
import '../../module_explore/explore_module.dart' as _i77;


class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._();

  _i2.AuthGuard _singletonAuthGuard;

  _i3.Logger _singletonLogger;

  _i4.LocalizationService _singletonLocalizationService;

  static _i5.Future<_i1.AppComponent> create() async {
    final injector = AppComponent$Injector._();

    return injector;
  }

  _i6.MyApp _createMyApp() => _i6.MyApp(
      _createChatModule(),
      _createCameraModule(),
      _createAuthModule(),
      _createProfileModule(),
      _createLocalizationService(),
      _createSwapThemeDataService(),
      _createHomeModule(),
      _createAnimeModlue(),
      _createNotificationModule(),
      _createAccountModule(),
      _createMainScreenModule(),
      _createSettingModule(),
      _createAuthModuleAnime(),
      _createExploreModule(),
      _createEpisodeModlue());
  _i7.ChatModule _createChatModule() =>
      _i7.ChatModule(_createChatPage(), _createAuthGuard());
  _i8.ChatPage _createChatPage() => _i8.ChatPage(_createChatPageBloc());
  _i9.ChatPageBloc _createChatPageBloc() =>
      _i9.ChatPageBloc(_createChatService());
  _i10.ChatService _createChatService() =>
      _i10.ChatService(_createChatManager());
  _i11.ChatManager _createChatManager() =>
      _i11.ChatManager(_createChatRepository());
  _i12.ChatRepository _createChatRepository() => _i12.ChatRepository();
  _i2.AuthGuard _createAuthGuard() =>
      _singletonAuthGuard ??= _i2.AuthGuard(_createSharedPreferencesHelper());
  _i13.SharedPreferencesHelper _createSharedPreferencesHelper() =>
      _i13.SharedPreferencesHelper();
  _i14.CameraModule _createCameraModule() =>
      _i14.CameraModule(_createCameraScreen());
  _i15.CameraScreen _createCameraScreen() => _i15.CameraScreen();
  _i16.AuthModule _createAuthModule() => _i16.AuthModule(_createAuthScreen());
  _i17.AuthScreen _createAuthScreen() =>
      _i17.AuthScreen(_createAuthStateManager());
  _i18.AuthStateManager _createAuthStateManager() =>
      _i18.AuthStateManager(_createAuthService());
  _i19.AuthService _createAuthService() =>
      _i19.AuthService(_createAuthPrefsHelper(), _createAuthManager());
  _i20.AuthPrefsHelper _createAuthPrefsHelper() => _i20.AuthPrefsHelper();
  _i21.AuthManager _createAuthManager() =>
      _i21.AuthManager(_createAuthRepository());
  _i22.AuthRepository _createAuthRepository() =>
      _i22.AuthRepository(_createApiClient());
  _i23.ApiClient _createApiClient() => _i23.ApiClient(_createLogger());
  _i3.Logger _createLogger() => _singletonLogger ??= _i3.Logger();
  _i24.ProfileModule _createProfileModule() =>
      _i24.ProfileModule(_createMyProfileScreen());
  _i25.MyProfileScreen _createMyProfileScreen() =>
      _i25.MyProfileScreen(_createMyProfileStateManager());
  _i26.MyProfileStateManager _createMyProfileStateManager() =>
      _i26.MyProfileStateManager(
          _createImageUploadService(), _createMyProfileService());
  _i27.ImageUploadService _createImageUploadService() =>
      _i27.ImageUploadService(_createUploadManager());
  _i28.UploadManager _createUploadManager() =>
      _i28.UploadManager(_createUploadRepository());
  _i29.UploadRepository _createUploadRepository() => _i29.UploadRepository();
  _i30.MyProfileService _createMyProfileService() => _i30.MyProfileService(
      _createMyProfileManager(),
      _createProfileSharedPreferencesHelper(),
      _createAuthService(),
      _createGeneralProfileService());
  _i31.MyProfileManager _createMyProfileManager() =>
      _i31.MyProfileManager(_createMyProfileRepository());
  _i32.MyProfileRepository _createMyProfileRepository() =>
      _i32.MyProfileRepository(_createApiClient());
  _i33.ProfileSharedPreferencesHelper _createProfileSharedPreferencesHelper() =>
      _i33.ProfileSharedPreferencesHelper();
  _i34.GeneralProfileService _createGeneralProfileService() =>
      _i34.GeneralProfileService();
  _i4.LocalizationService _createLocalizationService() =>
      _singletonLocalizationService ??=
          _i4.LocalizationService(_createLocalizationPreferencesHelper());
  _i35.LocalizationPreferencesHelper _createLocalizationPreferencesHelper() =>
      _i35.LocalizationPreferencesHelper();
  _i36.SwapThemeDataService _createSwapThemeDataService() =>
      _i36.SwapThemeDataService(_createThemePreferencesHelper());
  _i37.ThemePreferencesHelper _createThemePreferencesHelper() =>
      _i37.ThemePreferencesHelper();
  _i38.HomeModule _createHomeModule() => _i38.HomeModule(_createHomeScreen());
  _i39.HomeScreen _createHomeScreen() =>
      _i39.HomeScreen(_createHomeStateManager());
  _i40.HomeStateManager _createHomeStateManager() =>
      _i40.HomeStateManager(_createHomeService());
  _i41.HomeService _createHomeService() =>
      _i41.HomeService(_createHomeManager());
  _i42.HomeManager _createHomeManager() =>
      _i42.HomeManager(_createHomeRepository());
  _i43.HomeRepository _createHomeRepository() =>
      _i43.HomeRepository(_createApiClient());
  _i44.AnimeModlue _createAnimeModlue() =>
      _i44.AnimeModlue(_createAnimeDetailsScreen());
  _i45.AnimeDetailsScreen _createAnimeDetailsScreen() =>
      _i45.AnimeDetailsScreen(_createAnimeDetailsStateManager());
  _i46.AnimeDetailsStateManager _createAnimeDetailsStateManager() =>
      _i46.AnimeDetailsStateManager(_createAnimeDetailsService());
  _i47.AnimeDetailsService _createAnimeDetailsService() =>
      _i47.AnimeDetailsService(_createAnimeDetailsManager());
  _i48.AnimeDetailsManager _createAnimeDetailsManager() =>
      _i48.AnimeDetailsManager(_createAnimeDetailsRepository());
  _i49.AnimeDetailsRepository _createAnimeDetailsRepository() =>
      _i49.AnimeDetailsRepository(_createApiClient());
  _i50.NotificationModule _createNotificationModule() =>
      _i50.NotificationModule(_createNotificationScreen());
  _i51.NotificationScreen _createNotificationScreen() =>
      _i51.NotificationScreen(_createNotificationStateManager());
  _i52.NotificationStateManager _createNotificationStateManager() =>
      _i52.NotificationStateManager(_createNotificationService());
  _i53.NotificationService _createNotificationService() =>
      _i53.NotificationService(_createNotificationManager());
  _i54.NotificationManager _createNotificationManager() =>
      _i54.NotificationManager(_createNotificationRepository());
  _i55.NotificationRepository _createNotificationRepository() =>
      _i55.NotificationRepository();
  _i56.AccountModule _createAccountModule() =>
      _i56.AccountModule(_createInitAccountScreen());
  _i57.InitAccountScreen _createInitAccountScreen() =>
      _i57.InitAccountScreen(_createInitAccountStateManager());
  _i58.InitAccountStateManager _createInitAccountStateManager() =>
      _i58.InitAccountStateManager(_createInitAccountService());
  _i59.InitAccountService _createInitAccountService() =>
      _i59.InitAccountService(_createInitAccountManager());
  _i60.InitAccountManager _createInitAccountManager() =>
      _i60.InitAccountManager(_createInitAccountRepository());
  _i61.InitAccountRepository _createInitAccountRepository() =>
      _i61.InitAccountRepository(_createApiClient());
  _i62.MainScreenModule _createMainScreenModule() =>
      _i62.MainScreenModule(_createMainScreen());
  _i63.MainScreen _createMainScreen() => _i63.MainScreen(
      _createNotificationScreen(),
      _createHomeScreen(),
      _createAnimSetting(),
      _createExploreScreen());
  _i64.SettingsPage _createSettingsPage() => _i64.SettingsPage(
      _createAuthService(),
      _createLocalizationService(),
      _createSwapThemeDataService());
  _i65.ExploreScreen _createExploreScreen() =>
      _i65.ExploreScreen(_createExploreStateManager());
  _i66.ExploreStateManager _createExploreStateManager() =>
      _i66.ExploreStateManager(_createExploreService());
  _i67.ExploreService _createExploreService() =>
      _i67.ExploreService(_createExploreManager());
  _i68.ExploreManager _createExploreManager() =>
      _i68.ExploreManager(_createExploreRepository());
  _i69.ExploreRepository _createExploreRepository() =>
      _i69.ExploreRepository(_createApiClient());
  _i70.SettingModule _createSettingModule() =>
      _i70.SettingModule(_createAnimSetting());
  _i71.AnimSetting _createAnimSetting() =>
      _i71.AnimSetting(_createStyleSetting());
  _i72.StyleSetting _createStyleSetting() => _i72.StyleSetting();
  _i73.AuthModuleAnime _createAuthModuleAnime() =>
      _i73.AuthModuleAnime(_createSignUp(), _createSignIn());
  _i74.SignUp _createSignUp() => _i74.SignUp(_createStyleAuth());
  _i75.StyleAuth _createStyleAuth() => _i75.StyleAuth();
  _i76.SignIn _createSignIn() => _i76.SignIn(_createStyleAuth());
  _i77.ExploreModule _createExploreModule() =>
      _i77.ExploreModule(_createExploreScreen());
  @override
  _i6.MyApp get app => _createMyApp();
}
