
import 'package:anime_galaxy/module_notification/model/notification_model/notification_model.dart';

class NotificationState{}

class NotificationStateInit extends NotificationState{}

class NotificationStateFetching  extends NotificationState{}

class NotificationStateFetchingSuccess extends NotificationState{
  final List<NotificationModel> data;

  NotificationStateFetchingSuccess(this.data);

}

class NotificationStateFetchingError extends NotificationState{}