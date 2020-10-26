import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_notification/notification_routes.dart';
import 'package:anime_galaxy/module_notification/ui/screen/notification_screen/notification_screen.dart';
import 'package:inject/inject.dart';

@provide
class NotificationModule extends YesModule{
  final NotificationScreen _notificationScreen;

  NotificationModule(this._notificationScreen);

  @override
   getRoutes() {
    return{
      NotificationRoutes.ROUTE_NOTIFICATION_SCREEN : (context) => _notificationScreen,
    };
  }
}