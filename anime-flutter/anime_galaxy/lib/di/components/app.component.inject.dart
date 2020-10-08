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
import '../../module_profile/profile_module.dart' as _i21;
import '../../module_profile/ui/my_profile/my_profile.dart' as _i22;
import '../../module_profile/state_manager/my_profile/my_profile_state_manager.dart'
    as _i23;
import '../../module_upload/service/image_upload/image_upload_service.dart'
    as _i24;
import '../../module_upload/manager/upload_manager/upload_manager.dart' as _i25;
import '../../module_upload/repository/upload_repository/upload_repository.dart'
    as _i26;
import '../../module_profile/service/my_profile/my_profile.dart' as _i27;
import '../../module_profile/manager/my_profile_manager/my_profile_manager.dart'
    as _i28;
import '../../module_profile/repository/my_profile/my_profile.dart' as _i29;
import '../../module_network/http_client/http_client.dart' as _i30;
import '../../module_profile/presistance/profile_shared_preferences.dart'
    as _i31;
import '../../module_profile/service/general_profile/general_profile.dart'
    as _i32;
import '../../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i33;
import '../../module_theme/service/theme_service/theme_service.dart' as _i34;
import '../../module_theme/pressistance/theme_preferences_helper.dart' as _i35;
import '../../module_home/home.module.dart' as _i36;
import '../../module_home/ui/screens/home_screen.dart' as _i37;
import '../../anime_setting/routes/setting_module.dart' as _i38;
import '../../anime_setting/ui/screen/anim_setting.dart' as _i39;
import '../../anime_setting/ui/style_app.dart' as _i40;

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
      _createSettingModule());
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
      _i19.AuthService(_createAuthPrefsHelper());
  _i20.AuthPrefsHelper _createAuthPrefsHelper() => _i20.AuthPrefsHelper();
  _i21.ProfileModule _createProfileModule() =>
      _i21.ProfileModule(_createMyProfileScreen());
  _i22.MyProfileScreen _createMyProfileScreen() =>
      _i22.MyProfileScreen(_createMyProfileStateManager());
  _i23.MyProfileStateManager _createMyProfileStateManager() =>
      _i23.MyProfileStateManager(
          _createImageUploadService(), _createMyProfileService());
  _i24.ImageUploadService _createImageUploadService() =>
      _i24.ImageUploadService(_createUploadManager());
  _i25.UploadManager _createUploadManager() =>
      _i25.UploadManager(_createUploadRepository());
  _i26.UploadRepository _createUploadRepository() => _i26.UploadRepository();
  _i27.MyProfileService _createMyProfileService() => _i27.MyProfileService(
      _createMyProfileManager(),
      _createProfileSharedPreferencesHelper(),
      _createAuthService(),
      _createGeneralProfileService());
  _i28.MyProfileManager _createMyProfileManager() =>
      _i28.MyProfileManager(_createMyProfileRepository());
  _i29.MyProfileRepository _createMyProfileRepository() =>
      _i29.MyProfileRepository(_createApiClient());
  _i30.ApiClient _createApiClient() => _i30.ApiClient(_createLogger());
  _i3.Logger _createLogger() => _singletonLogger ??= _i3.Logger();
  _i31.ProfileSharedPreferencesHelper _createProfileSharedPreferencesHelper() =>
      _i31.ProfileSharedPreferencesHelper();
  _i32.GeneralProfileService _createGeneralProfileService() =>
      _i32.GeneralProfileService();
  _i4.LocalizationService _createLocalizationService() =>
      _singletonLocalizationService ??=
          _i4.LocalizationService(_createLocalizationPreferencesHelper());
  _i33.LocalizationPreferencesHelper _createLocalizationPreferencesHelper() =>
      _i33.LocalizationPreferencesHelper();
  _i34.SwapThemeDataService _createSwapThemeDataService() =>
      _i34.SwapThemeDataService(_createThemePreferencesHelper());
  _i35.ThemePreferencesHelper _createThemePreferencesHelper() =>
      _i35.ThemePreferencesHelper();
  _i36.HomeModule _createHomeModule() => _i36.HomeModule(_createHomeScreen());
  _i37.HomeScreen _createHomeScreen() => _i37.HomeScreen();
  _i38.SettingModule _createSettingModule() =>
      _i38.SettingModule(_createAnimSetting());
  _i39.AnimSetting _createAnimSetting() =>
      _i39.AnimSetting(_createStyleSetting());
  _i40.StyleSetting _createStyleSetting() => _i40.StyleSetting();
  @override
  _i6.MyApp get app => _createMyApp();
}
