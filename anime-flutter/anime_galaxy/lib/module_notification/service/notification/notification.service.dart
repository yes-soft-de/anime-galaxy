
import 'package:anime_galaxy/module_notification/manager/notification/notification.manager.dart';
import 'package:anime_galaxy/module_notification/model/notification_model/notification_model.dart';
import 'package:anime_galaxy/module_notification/response/notification_response/notification_response.dart';
import 'package:inject/inject.dart';

@provide
class NotificationService{
  final NotificationManager _notificationManager;

  NotificationService(this._notificationManager);

  Future<List<NotificationModel>> getNotifications() async{
    List<NotificationResponse> result = await _notificationManager.getNotifications();
    List<NotificationModel> notifications = [];

    result.forEach((element) {
      notifications.add(
        new NotificationModel(
          content: element.animeName,
          image: element.mainImage,
          date: ''
        )
      );
    });

    return notifications;
  }
}