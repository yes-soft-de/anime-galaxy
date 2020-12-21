
import 'package:anime_galaxy/module_notification/repository/notification/notification.repository.dart';
import 'package:anime_galaxy/module_notification/response/notification_response/notification_response.dart';
import 'package:inject/inject.dart';

@provide
class NotificationManager{
  final NotificationRepository _notificationRepository;

  NotificationManager(this._notificationRepository);

  Future<List<NotificationResponse>> getNotifications() async{
     return await _notificationRepository.getNotifications();
  }


}