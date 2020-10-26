
import 'package:anime_galaxy/module_notification/model/notification_model/notification_model.dart';
import 'package:anime_galaxy/module_notification/repository/notification/notification.repository.dart';
import 'package:inject/inject.dart';

@provide
class NotificationManager{
  final NotificationRepository _notificationRepository;

  NotificationManager(this._notificationRepository);

  Future<List<NotificationModel>> getNotifications() async{
     return await _notificationRepository.getNotifications();
  }


}