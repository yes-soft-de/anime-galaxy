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
import '../../module_profile/service/my_profile/my_profile.dart' as _i24;
import '../../module_profile/manager/my_profile_manager/my_profile_manager.dart'
    as _i25;
import '../../module_profile/repository/my_profile/my_profile.repository.dart'
    as _i26;
import '../../module_profile/presistance/profile_shared_preferences.dart'
    as _i27;
import '../../module_profile/service/general_profile/general_profile.dart'
    as _i28;
import '../../module_error/error_module.dart' as _i29;
import '../../module_error/ui/screen/error_screen.dart' as _i30;
import '../../module_profile/profile_module.dart' as _i31;
import '../../module_profile/ui/screen/profile_screen/profile_screen.dart'
    as _i32;
import '../../module_profile/state_manager/my_profile/my_profile_state_manager.dart'
    as _i33;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i34;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i35;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i36;
import '../../module_profile/ui/screen/my_profile/my_profile.dart' as _i37;
import '../../module_profile/state_manager/edit_profile_state_manager/edit_profile_state_manager.dart'
    as _i38;
import '../../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i39;
import '../../module_theme/service/theme_service/theme_service.dart' as _i40;
import '../../module_theme/pressistance/theme_preferences_helper.dart' as _i41;
import '../../module_home/home.module.dart' as _i42;
import '../../module_home/ui/screens/home_screen.dart' as _i43;
import '../../module_home/state_manager/home/home.state_manager.dart' as _i44;
import '../../module_home/service/home/home.service.dart' as _i45;
import '../../module_home/manager/home/home.manager.dart' as _i46;
import '../../module_home/repository/home/home.repository.dart' as _i47;
import '../../module_anime/anime_module.dart' as _i48;
import '../../module_anime/ui/screen/anime_details_screen/anime_details_screen.dart'
    as _i49;
import '../../module_anime/state_manager/anime_details/anime_details.state_manager.dart'
    as _i50;
import '../../module_anime/service/anime_details/anime_details.service.dart'
    as _i51;
import '../../module_anime/manager/anime_details/anime_details.manager.dart'
    as _i52;
import '../../module_anime/repository/anime_details/anime_details.repository.dart'
    as _i53;
import '../../module_navigation/ui/widget/navigation_drawer/anime_navigation_drawer.dart'
    as _i54;
import '../../module_notification/notification_module.dart' as _i55;
import '../../module_notification/ui/screen/notification_screen/notification_screen.dart'
    as _i56;
import '../../module_notification/state_manager/notification/notification.state_manager.dart'
    as _i57;
import '../../module_notification/service/notification/notification.service.dart'
    as _i58;
import '../../module_notification/manager/notification/notification.manager.dart'
    as _i59;
import '../../module_notification/repository/notification/notification.repository.dart'
    as _i60;
import '../../module_init_account/account_module.dart' as _i61;
import '../../module_init_account/ui/screen/init_account_screen.dart' as _i62;
import '../../module_init_account/state_manager/init_account/init_account.state_manager.dart'
    as _i63;
import '../../module_init_account/service/init_account/init_account.service.dart'
    as _i64;
import '../../module_init_account/manager/init_account/init_account.manager.dart'
    as _i65;
import '../../module_init_account/repository/init_account/init_account.repository.dart'
    as _i66;
import '../../main_screen/main_screen_module.dart' as _i67;
import '../../main_screen/ui/screen/main_screen.dart' as _i68;
import '../../module_settings/ui/ui/settings_page/settings_page.dart' as _i69;
import '../../module_explore/ui/screen/explore_screen/explore_screen.dart'
    as _i70;
import '../../module_explore/state_manager/explore/explore.state_manager.dart'
    as _i71;
import '../../module_explore/service/explore/explore.service.dart' as _i72;
import '../../module_explore/manager/explore/explore.manager.dart' as _i73;
import '../../module_explore/repository/explore/explore.repositry.dart' as _i74;
import '../../module_settings/setting_module.dart' as _i75;
import '../../module_explore/explore_module.dart' as _i76;
import '../../module_episode/episode_module.dart' as _i77;
import '../../module_episode/ui/screen/episode_details_screen/episode_details_screen.dart'
    as _i78;
import '../../module_episode/state_manager/episode_details/episode_details.state_manager.dart'
    as _i79;
import '../../module_episode/service/episode_details/episode_details.service.dart'
    as _i80;
import '../../module_episode/manager/episode_details/episode_details.manager.dart'
    as _i81;
import '../../module_episode/repository/episode_details/episode_details.repository.dart'
    as _i82;

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
      _createErrorModule(),
      _createProfileModule(),
      _createLocalizationService(),
      _createSwapThemeDataService(),
      _createAuthService(),
      _createHomeModule(),
      _createAnimeModule(),
      _createNotificationModule(),
      _createAccountModule(),
      _createMainScreenModule(),
      _createSettingModule(),
      _createExploreModule(),
      _createEpisodeModule());
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
      _i18.AuthStateManager(_createAuthService(), _createMyProfileService());
  _i19.AuthService _createAuthService() =>
      _i19.AuthService(_createAuthPrefsHelper(), _createAuthManager());
  _i20.AuthPrefsHelper _createAuthPrefsHelper() => _i20.AuthPrefsHelper();
  _i21.AuthManager _createAuthManager() =>
      _i21.AuthManager(_createAuthRepository());
  _i22.AuthRepository _createAuthRepository() =>
      _i22.AuthRepository(_createApiClient());
  _i23.ApiClient _createApiClient() => _i23.ApiClient(_createLogger());
  _i3.Logger _createLogger() => _singletonLogger ??= _i3.Logger();
  _i24.MyProfileService _createMyProfileService() => _i24.MyProfileService(
      _createMyProfileManager(),
      _createProfileSharedPreferencesHelper(),
      _createAuthService(),
      _createGeneralProfileService());
  _i25.MyProfileManager _createMyProfileManager() =>
      _i25.MyProfileManager(_createMyProfileRepository());
  _i26.MyProfileRepository _createMyProfileRepository() =>
      _i26.MyProfileRepository(_createApiClient(), _createAuthPrefsHelper());
  _i27.ProfileSharedPreferencesHelper _createProfileSharedPreferencesHelper() =>
      _i27.ProfileSharedPreferencesHelper();
  _i28.GeneralProfileService _createGeneralProfileService() =>
      _i28.GeneralProfileService();
  _i29.ErrorModule _createErrorModule() =>
      _i29.ErrorModule(_createErrorScreen());
  _i30.ErrorScreen _createErrorScreen() => _i30.ErrorScreen();
  _i31.ProfileModule _createProfileModule() =>
      _i31.ProfileModule(_createProfileScreen(), _createMyProfileScreen());
  _i32.ProfileScreen _createProfileScreen() => _i32.ProfileScreen(
      _createAuthService(),
      _createMyProfileStateManager(),
      _createProfileSharedPreferencesHelper());
  _i33.MyProfileStateManager _createMyProfileStateManager() =>
      _i33.MyProfileStateManager(
          _createImageUploadService(), _createMyProfileService());
  _i34.ImageUploadService _createImageUploadService() =>
      _i34.ImageUploadService(_createUploadManager());
  _i35.UploadManager _createUploadManager() =>
      _i35.UploadManager(_createUploadRepository());
  _i36.UploadRepository _createUploadRepository() => _i36.UploadRepository();
  _i37.MyProfileScreen _createMyProfileScreen() => _i37.MyProfileScreen(
      _createEditProfileStateManager(), _createImageUploadService());
  _i38.EditProfileStateManager _createEditProfileStateManager() =>
      _i38.EditProfileStateManager(
          _createMyProfileService(), _createImageUploadService());
  _i4.LocalizationService _createLocalizationService() =>
      _singletonLocalizationService ??=
          _i4.LocalizationService(_createLocalizationPreferencesHelper());
  _i39.LocalizationPreferencesHelper _createLocalizationPreferencesHelper() =>
      _i39.LocalizationPreferencesHelper();
  _i40.SwapThemeDataService _createSwapThemeDataService() =>
      _i40.SwapThemeDataService(_createThemePreferencesHelper());
  _i41.ThemePreferencesHelper _createThemePreferencesHelper() =>
      _i41.ThemePreferencesHelper();
  _i42.HomeModule _createHomeModule() => _i42.HomeModule(_createHomeScreen());
  _i43.HomeScreen _createHomeScreen() =>
      _i43.HomeScreen(_createHomeStateManager(), _createAuthService());
  _i44.HomeStateManager _createHomeStateManager() =>
      _i44.HomeStateManager(_createHomeService());
  _i45.HomeService _createHomeService() =>
      _i45.HomeService(_createHomeManager(), _createAuthPrefsHelper());
  _i46.HomeManager _createHomeManager() =>
      _i46.HomeManager(_createHomeRepository());
  _i47.HomeRepository _createHomeRepository() =>
      _i47.HomeRepository(_createApiClient());
  _i48.AnimeModule _createAnimeModule() =>
      _i48.AnimeModule(_createAnimeDetailsScreen());
  _i49.AnimeDetailsScreen _createAnimeDetailsScreen() =>
      _i49.AnimeDetailsScreen(
          _createAnimeDetailsStateManager(),
          _createAuthService(),
          _createAnimeNavigationDrawer(),
          _createProfileSharedPreferencesHelper());
  _i50.AnimeDetailsStateManager _createAnimeDetailsStateManager() =>
      _i50.AnimeDetailsStateManager(_createAnimeDetailsService());
  _i51.AnimeDetailsService _createAnimeDetailsService() =>
      _i51.AnimeDetailsService(
          _createAnimeDetailsManager(), _createAuthService());
  _i52.AnimeDetailsManager _createAnimeDetailsManager() =>
      _i52.AnimeDetailsManager(_createAnimeDetailsRepository());
  _i53.AnimeDetailsRepository _createAnimeDetailsRepository() =>
      _i53.AnimeDetailsRepository(_createApiClient(), _createAuthPrefsHelper());
  _i54.AnimeNavigationDrawer _createAnimeNavigationDrawer() =>
      _i54.AnimeNavigationDrawer(_createProfileSharedPreferencesHelper());
  _i55.NotificationModule _createNotificationModule() =>
      _i55.NotificationModule(_createNotificationScreen());
  _i56.NotificationScreen _createNotificationScreen() =>
      _i56.NotificationScreen(_createNotificationStateManager());
  _i57.NotificationStateManager _createNotificationStateManager() =>
      _i57.NotificationStateManager(_createNotificationService());
  _i58.NotificationService _createNotificationService() =>
      _i58.NotificationService(_createNotificationManager());
  _i59.NotificationManager _createNotificationManager() =>
      _i59.NotificationManager(_createNotificationRepository());
  _i60.NotificationRepository _createNotificationRepository() =>
      _i60.NotificationRepository(_createApiClient(), _createAuthService());
  _i61.AccountModule _createAccountModule() =>
      _i61.AccountModule(_createInitAccountScreen());
  _i62.InitAccountScreen _createInitAccountScreen() =>
      _i62.InitAccountScreen(_createInitAccountStateManager());
  _i63.InitAccountStateManager _createInitAccountStateManager() =>
      _i63.InitAccountStateManager(_createInitAccountService());
  _i64.InitAccountService _createInitAccountService() =>
      _i64.InitAccountService(
          _createInitAccountManager(), _createAuthService());
  _i65.InitAccountManager _createInitAccountManager() =>
      _i65.InitAccountManager(_createInitAccountRepository());
  _i66.InitAccountRepository _createInitAccountRepository() =>
      _i66.InitAccountRepository(_createApiClient());
  _i67.MainScreenModule _createMainScreenModule() =>
      _i67.MainScreenModule(_createMainScreen());
  _i68.MainScreen _createMainScreen() => _i68.MainScreen(
      _createNotificationScreen(),
      _createHomeScreen(),
      _createSettingsPage(),
      _createExploreScreen(),
      _createProfileScreen(),
      _createAuthService(),
      _createAnimeNavigationDrawer(),
      _createProfileSharedPreferencesHelper());
  _i69.SettingsPage _createSettingsPage() => _i69.SettingsPage(
      _createAuthService(),
      _createLocalizationService(),
      _createSwapThemeDataService(),
      _createProfileSharedPreferencesHelper());
  _i70.ExploreScreen _createExploreScreen() =>
      _i70.ExploreScreen(_createExploreStateManager());
  _i71.ExploreStateManager _createExploreStateManager() =>
      _i71.ExploreStateManager(_createExploreService());
  _i72.ExploreService _createExploreService() =>
      _i72.ExploreService(_createExploreManager());
  _i73.ExploreManager _createExploreManager() =>
      _i73.ExploreManager(_createExploreRepository());
  _i74.ExploreRepository _createExploreRepository() =>
      _i74.ExploreRepository(_createApiClient(), _createAuthPrefsHelper());
  _i75.SettingModule _createSettingModule() =>
      _i75.SettingModule(_createSettingsPage());
  _i76.ExploreModule _createExploreModule() =>
      _i76.ExploreModule(_createExploreScreen());
  _i77.EpisodeModule _createEpisodeModule() =>
      _i77.EpisodeModule(_createEpisodeDetailsScreen());
  _i78.EpisodeDetailsScreen _createEpisodeDetailsScreen() =>
      _i78.EpisodeDetailsScreen(
          _createEpisodeDetailsStateManager(),
          _createAuthService(),
          _createAnimeNavigationDrawer(),
          _createProfileSharedPreferencesHelper());
  _i79.EpisodeDetailsStateManager _createEpisodeDetailsStateManager() =>
      _i79.EpisodeDetailsStateManager(_createEpisodeDetailsService());
  _i80.EpisodeDetailsService _createEpisodeDetailsService() =>
      _i80.EpisodeDetailsService(
          _createEpisodeDetailsManager(), _createAuthPrefsHelper());
  _i81.EpisodeDetailsManager _createEpisodeDetailsManager() =>
      _i81.EpisodeDetailsManager(_createEpisodeDetailsRepository());
  _i82.EpisodeDetailsRepository _createEpisodeDetailsRepository() =>
      _i82.EpisodeDetailsRepository(
          _createApiClient(), _createAuthPrefsHelper());
  @override
  _i6.MyApp get app => _createMyApp();
}
