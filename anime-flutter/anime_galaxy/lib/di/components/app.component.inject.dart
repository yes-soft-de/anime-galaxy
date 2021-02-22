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
import '../../module_profile/manager/my_profile_manager/my_profile_manager.dart'
    as _i24;
import '../../module_profile/repository/my_profile/my_profile.repository.dart'
    as _i25;
import '../../module_profile/presistance/profile_shared_preferences.dart'
    as _i26;
import '../../module_auth/ui/screen/forgot_password_screen/forgot_password_screen.dart'
    as _i27;
import '../../module_auth/state_manager/forgot_password_state_manager/auth_state_manager.dart'
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
import '../../module_profile/service/my_profile/my_profile.dart' as _i37;
import '../../module_profile/service/general_profile/general_profile.dart'
    as _i38;
import '../../module_theme/service/theme_service/theme_service.dart' as _i39;
import '../../module_theme/pressistance/theme_preferences_helper.dart' as _i40;
import '../../module_profile/ui/screen/my_profile/my_profile.dart' as _i41;
import '../../module_profile/state_manager/edit_profile_state_manager/edit_profile_state_manager.dart'
    as _i42;
import '../../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i43;
import '../../module_home/home.module.dart' as _i44;
import '../../module_anime/anime_module.dart' as _i45;
import '../../module_anime/ui/screen/anime_details_screen/anime_details_screen.dart'
    as _i46;
import '../../module_anime/state_manager/anime_details/anime_details.state_manager.dart'
    as _i47;
import '../../module_anime/service/anime_details/anime_details.service.dart'
    as _i48;
import '../../module_anime/manager/anime_details/anime_details.manager.dart'
    as _i49;
import '../../module_anime/repository/anime_details/anime_details.repository.dart'
    as _i50;
import '../../module_notification/notification_module.dart' as _i51;
import '../../module_notification/ui/screen/notification_screen/notification_screen.dart'
    as _i52;
import '../../module_notification/state_manager/notification/notification.state_manager.dart'
    as _i53;
import '../../module_notification/service/notification/notification.service.dart'
    as _i54;
import '../../module_notification/manager/notification/notification.manager.dart'
    as _i55;
import '../../module_notification/repository/notification/notification.repository.dart'
    as _i56;
import '../../module_init_account/account_module.dart' as _i57;
import '../../module_init_account/ui/screen/init_account_screen.dart' as _i58;
import '../../module_init_account/state_manager/init_account/init_account.state_manager.dart'
    as _i59;
import '../../module_init_account/service/init_account/init_account.service.dart'
    as _i60;
import '../../module_init_account/manager/init_account/init_account.manager.dart'
    as _i61;
import '../../module_init_account/repository/init_account/init_account.repository.dart'
    as _i62;
import '../../main_screen/main_screen_module.dart' as _i63;
import '../../main_screen/ui/screen/main_screen.dart' as _i64;
import '../../module_home/ui/screens/home_screen.dart' as _i65;
import '../../module_home/state_manager/home/home.state_manager.dart' as _i66;
import '../../module_home/service/home/home.service.dart' as _i67;
import '../../module_home/manager/home/home.manager.dart' as _i68;
import '../../module_home/repository/home/home.repository.dart' as _i69;
import '../../module_settings/ui/ui/settings_page/settings_page.dart' as _i70;
import '../../module_explore/ui/screen/explore_screen/explore_screen.dart'
    as _i71;
import '../../module_explore/state_manager/explore/explore.state_manager.dart'
    as _i72;
import '../../module_explore/service/explore/explore.service.dart' as _i73;
import '../../module_explore/manager/explore/explore.manager.dart' as _i74;
import '../../module_explore/repository/explore/explore.repositry.dart' as _i75;
import '../../module_navigation/ui/widget/navigation_drawer/anime_navigation_drawer.dart'
    as _i76;
import '../../module_settings/setting_module.dart' as _i77;
import '../../module_explore/explore_module.dart' as _i78;
import '../../module_explore/ui/screen/category_animes_screen/category_animes_screen.dart'
    as _i79;
import '../../module_explore/state_manager/category_animes/category_animes.state_manager.dart'
    as _i80;
import '../../module_explore/service/category_animes/category_animes.service.dart'
    as _i81;
import '../../module_explore/manager/category_animes/category_animes.manager.dart'
    as _i82;
import '../../module_explore/repository/category_animes/category_animes.repository.dart'
    as _i83;
import '../../module_episode/episode_module.dart' as _i84;
import '../../module_episode/ui/screen/episode_details_screen/episode_details_screen.dart'
    as _i85;
import '../../module_episode/state_manager/episode_details/episode_details.state_manager.dart'
    as _i86;
import '../../module_episode/service/episode_details/episode_details.service.dart'
    as _i87;
import '../../module_episode/manager/episode_details/episode_details.manager.dart'
    as _i88;
import '../../module_episode/repository/episode_details/episode_details.repository.dart'
    as _i89;
import '../../module_search/search_module.dart' as _i90;
import '../../module_search/ui/screen/search_screen/seach_screen.dart' as _i91;
import '../../module_search/state_manager/search/search.state_manager.dart'
    as _i92;
import '../../module_search/service/search_service/search.service.dart' as _i93;
import '../../module_search/manager/search_manager/search.manager.dart' as _i94;
import '../../module_search/repository/search_repository/search.repository.dart'
    as _i95;

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
      _createHomeModule(),
      _createAnimeModule(),
      _createNotificationModule(),
      _createAccountModule(),
      _createMainScreenModule(),
      _createSettingModule(),
      _createExploreModule(),
      _createEpisodeModule(),
      _createSearchModule());
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
  _i16.AuthModule _createAuthModule() =>
      _i16.AuthModule(_createAuthScreen(), _createForgotPasswordScreen());
  _i17.AuthScreen _createAuthScreen() =>
      _i17.AuthScreen(_createAuthStateManager());
  _i18.AuthStateManager _createAuthStateManager() =>
      _i18.AuthStateManager(_createAuthService());
  _i19.AuthService _createAuthService() => _i19.AuthService(
      _createAuthPrefsHelper(),
      _createAuthManager(),
      _createMyProfileManager(),
      _createProfileSharedPreferencesHelper());
  _i20.AuthPrefsHelper _createAuthPrefsHelper() => _i20.AuthPrefsHelper();
  _i21.AuthManager _createAuthManager() =>
      _i21.AuthManager(_createAuthRepository());
  _i22.AuthRepository _createAuthRepository() =>
      _i22.AuthRepository(_createApiClient());
  _i23.ApiClient _createApiClient() => _i23.ApiClient(_createLogger());
  _i3.Logger _createLogger() => _singletonLogger ??= _i3.Logger();
  _i24.MyProfileManager _createMyProfileManager() =>
      _i24.MyProfileManager(_createMyProfileRepository());
  _i25.MyProfileRepository _createMyProfileRepository() =>
      _i25.MyProfileRepository(_createApiClient(), _createAuthPrefsHelper());
  _i26.ProfileSharedPreferencesHelper _createProfileSharedPreferencesHelper() =>
      _i26.ProfileSharedPreferencesHelper();
  _i27.ForgotPasswordScreen _createForgotPasswordScreen() =>
      _i27.ForgotPasswordScreen(_createForgotPasswordStateManager());
  _i28.ForgotPasswordStateManager _createForgotPasswordStateManager() =>
      _i28.ForgotPasswordStateManager(_createAuthService());
  _i29.ErrorModule _createErrorModule() =>
      _i29.ErrorModule(_createErrorScreen());
  _i30.ErrorScreen _createErrorScreen() => _i30.ErrorScreen();
  _i31.ProfileModule _createProfileModule() =>
      _i31.ProfileModule(_createProfileScreen(), _createMyProfileScreen());
  _i32.ProfileScreen _createProfileScreen() => _i32.ProfileScreen(
      _createMyProfileStateManager(), _createSwapThemeDataService());
  _i33.MyProfileStateManager _createMyProfileStateManager() =>
      _i33.MyProfileStateManager(
          _createImageUploadService(), _createMyProfileService());
  _i34.ImageUploadService _createImageUploadService() =>
      _i34.ImageUploadService(_createUploadManager());
  _i35.UploadManager _createUploadManager() =>
      _i35.UploadManager(_createUploadRepository());
  _i36.UploadRepository _createUploadRepository() => _i36.UploadRepository();
  _i37.MyProfileService _createMyProfileService() => _i37.MyProfileService(
      _createMyProfileManager(),
      _createProfileSharedPreferencesHelper(),
      _createAuthService(),
      _createGeneralProfileService(),
      _createImageUploadService());
  _i38.GeneralProfileService _createGeneralProfileService() =>
      _i38.GeneralProfileService();
  _i39.SwapThemeDataService _createSwapThemeDataService() =>
      _i39.SwapThemeDataService(_createThemePreferencesHelper());
  _i40.ThemePreferencesHelper _createThemePreferencesHelper() =>
      _i40.ThemePreferencesHelper();
  _i41.MyProfileScreen _createMyProfileScreen() => _i41.MyProfileScreen(
      _createEditProfileStateManager(),
      _createImageUploadService(),
      _createProfileSharedPreferencesHelper());
  _i42.EditProfileStateManager _createEditProfileStateManager() =>
      _i42.EditProfileStateManager(_createMyProfileService());
  _i4.LocalizationService _createLocalizationService() =>
      _singletonLocalizationService ??=
          _i4.LocalizationService(_createLocalizationPreferencesHelper());
  _i43.LocalizationPreferencesHelper _createLocalizationPreferencesHelper() =>
      _i43.LocalizationPreferencesHelper();
  _i44.HomeModule _createHomeModule() => _i44.HomeModule();
  _i45.AnimeModule _createAnimeModule() =>
      _i45.AnimeModule(_createAnimeDetailsScreen());
  _i46.AnimeDetailsScreen _createAnimeDetailsScreen() =>
      _i46.AnimeDetailsScreen(
          _createAnimeDetailsStateManager(),
          _createAuthService(),
          _createProfileSharedPreferencesHelper(),
          _createSwapThemeDataService());
  _i47.AnimeDetailsStateManager _createAnimeDetailsStateManager() =>
      _i47.AnimeDetailsStateManager(_createAnimeDetailsService());
  _i48.AnimeDetailsService _createAnimeDetailsService() =>
      _i48.AnimeDetailsService(
          _createAnimeDetailsManager(), _createAuthService());
  _i49.AnimeDetailsManager _createAnimeDetailsManager() =>
      _i49.AnimeDetailsManager(_createAnimeDetailsRepository());
  _i50.AnimeDetailsRepository _createAnimeDetailsRepository() =>
      _i50.AnimeDetailsRepository(
          _createApiClient(), _createAuthPrefsHelper(), _createAuthService());
  _i51.NotificationModule _createNotificationModule() =>
      _i51.NotificationModule(_createNotificationScreen());
  _i52.NotificationScreen _createNotificationScreen() =>
      _i52.NotificationScreen(_createNotificationStateManager());
  _i53.NotificationStateManager _createNotificationStateManager() =>
      _i53.NotificationStateManager(_createNotificationService());
  _i54.NotificationService _createNotificationService() =>
      _i54.NotificationService(_createNotificationManager());
  _i55.NotificationManager _createNotificationManager() =>
      _i55.NotificationManager(_createNotificationRepository());
  _i56.NotificationRepository _createNotificationRepository() =>
      _i56.NotificationRepository(_createApiClient(), _createAuthService());
  _i57.AccountModule _createAccountModule() =>
      _i57.AccountModule(_createInitAccountScreen());
  _i58.InitAccountScreen _createInitAccountScreen() =>
      _i58.InitAccountScreen(_createInitAccountStateManager());
  _i59.InitAccountStateManager _createInitAccountStateManager() =>
      _i59.InitAccountStateManager(_createInitAccountService());
  _i60.InitAccountService _createInitAccountService() =>
      _i60.InitAccountService(
          _createInitAccountManager(), _createAuthService());
  _i61.InitAccountManager _createInitAccountManager() =>
      _i61.InitAccountManager(_createInitAccountRepository());
  _i62.InitAccountRepository _createInitAccountRepository() =>
      _i62.InitAccountRepository(_createApiClient());
  _i63.MainScreenModule _createMainScreenModule() =>
      _i63.MainScreenModule(_createMainScreen());
  _i64.MainScreen _createMainScreen() => _i64.MainScreen(
      _createNotificationScreen(),
      _createHomeScreen(),
      _createSettingsPage(),
      _createExploreScreen(),
      _createProfileScreen(),
      _createAuthService(),
      _createAnimeNavigationDrawer(),
      _createProfileSharedPreferencesHelper());
  _i65.HomeScreen _createHomeScreen() => _i65.HomeScreen(
      _createHomeStateManager(),
      _createAuthService(),
      _createSwapThemeDataService());
  _i66.HomeStateManager _createHomeStateManager() =>
      _i66.HomeStateManager(_createHomeService());
  _i67.HomeService _createHomeService() =>
      _i67.HomeService(_createHomeManager(), _createAuthPrefsHelper());
  _i68.HomeManager _createHomeManager() =>
      _i68.HomeManager(_createHomeRepository());
  _i69.HomeRepository _createHomeRepository() =>
      _i69.HomeRepository(_createApiClient());
  _i70.SettingsPage _createSettingsPage() => _i70.SettingsPage(
      _createAuthService(),
      _createSwapThemeDataService(),
      _createProfileSharedPreferencesHelper());
  _i71.ExploreScreen _createExploreScreen() => _i71.ExploreScreen(
      _createExploreStateManager(), _createSwapThemeDataService());
  _i72.ExploreStateManager _createExploreStateManager() =>
      _i72.ExploreStateManager(_createExploreService());
  _i73.ExploreService _createExploreService() =>
      _i73.ExploreService(_createExploreManager());
  _i74.ExploreManager _createExploreManager() =>
      _i74.ExploreManager(_createExploreRepository());
  _i75.ExploreRepository _createExploreRepository() =>
      _i75.ExploreRepository(_createApiClient(), _createAuthPrefsHelper());
  _i76.AnimeNavigationDrawer _createAnimeNavigationDrawer() =>
      _i76.AnimeNavigationDrawer(_createProfileSharedPreferencesHelper());
  _i77.SettingModule _createSettingModule() =>
      _i77.SettingModule(_createSettingsPage());
  _i78.ExploreModule _createExploreModule() =>
      _i78.ExploreModule(_createExploreScreen(), _createCategoryAnimesScreen());
  _i79.CategoryAnimesScreen _createCategoryAnimesScreen() =>
      _i79.CategoryAnimesScreen(_createCategoryAnimesStateManager());
  _i80.CategoryAnimesStateManager _createCategoryAnimesStateManager() =>
      _i80.CategoryAnimesStateManager(_createCategoryAnimesService());
  _i81.CategoryAnimesService _createCategoryAnimesService() =>
      _i81.CategoryAnimesService(_createCategoryAnimesManager());
  _i82.CategoryAnimesManager _createCategoryAnimesManager() =>
      _i82.CategoryAnimesManager(_createCategoryAnimesRepository());
  _i83.CategoryAnimesRepository _createCategoryAnimesRepository() =>
      _i83.CategoryAnimesRepository(_createApiClient());
  _i84.EpisodeModule _createEpisodeModule() =>
      _i84.EpisodeModule(_createEpisodeDetailsScreen());
  _i85.EpisodeDetailsScreen _createEpisodeDetailsScreen() =>
      _i85.EpisodeDetailsScreen(
          _createEpisodeDetailsStateManager(),
          _createAuthService(),
          _createAnimeNavigationDrawer(),
          _createProfileSharedPreferencesHelper(),
          _createSwapThemeDataService());
  _i86.EpisodeDetailsStateManager _createEpisodeDetailsStateManager() =>
      _i86.EpisodeDetailsStateManager(_createEpisodeDetailsService());
  _i87.EpisodeDetailsService _createEpisodeDetailsService() =>
      _i87.EpisodeDetailsService(
          _createEpisodeDetailsManager(), _createAuthPrefsHelper());
  _i88.EpisodeDetailsManager _createEpisodeDetailsManager() =>
      _i88.EpisodeDetailsManager(_createEpisodeDetailsRepository());
  _i89.EpisodeDetailsRepository _createEpisodeDetailsRepository() =>
      _i89.EpisodeDetailsRepository(
          _createApiClient(), _createAuthPrefsHelper(), _createAuthService());
  _i90.SearchModule _createSearchModule() =>
      _i90.SearchModule(_createSearchScreen());
  _i91.SearchScreen _createSearchScreen() =>
      _i91.SearchScreen(_createSearchStateManager());
  _i92.SearchStateManager _createSearchStateManager() =>
      _i92.SearchStateManager(_createSearchService());
  _i93.SearchService _createSearchService() =>
      _i93.SearchService(_createSearchManager());
  _i94.SearchManager _createSearchManager() =>
      _i94.SearchManager(_createSearchRepository());
  _i95.SearchRepository _createSearchRepository() =>
      _i95.SearchRepository(_createApiClient());
  @override
  _i6.MyApp get app => _createMyApp();
}
