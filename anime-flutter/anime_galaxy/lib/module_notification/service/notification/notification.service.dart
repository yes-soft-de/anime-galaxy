
import 'package:anime_galaxy/module_notification/manager/notification/notification.manager.dart';
import 'package:anime_galaxy/module_notification/model/notification_model/notification_model.dart';
import 'package:inject/inject.dart';

@provide
class NotificationService{
  final NotificationManager _notificationManager;

  NotificationService(this._notificationManager);

  Future<List<NotificationModel>> getNotifications() async{
    return await _notificationManager.getNotifications();
  }
}