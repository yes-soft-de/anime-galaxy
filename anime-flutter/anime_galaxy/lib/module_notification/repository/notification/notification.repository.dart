
import 'package:anime_galaxy/module_notification/model/notification_model/notification_model.dart';
import 'package:inject/inject.dart';

List<NotificationModel> notifications =[
  new NotificationModel(image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',content: 'تم صدور حلقة جديدة من ون بيس',date: 'منذ ساعتين'),
  new NotificationModel(image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',content: 'تم صدور حلقة جديدة من ون بيس',date: 'منذ ساعتين'),
  new NotificationModel(image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',content: 'تم صدور حلقة جديدة من ون بيس',date: 'منذ ساعتين'),
  new NotificationModel(image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',content: 'تم صدور حلقة جديدة من ون بيس',date: 'منذ ساعتين'),
  new NotificationModel(image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',content: 'تم صدور حلقة جديدة من ون بيس',date: 'منذ ساعتين'),
  new NotificationModel(image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',content: 'تم صدور حلقة جديدة من ون بيس',date: 'منذ ساعتين'),
  new NotificationModel(image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',content: 'تم صدور حلقة جديدة من ون بيس',date: 'منذ ساعتين'),
  new NotificationModel(image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',content: 'تم صدور حلقة جديدة من ون بيس',date: 'منذ ساعتين'),
  new NotificationModel(image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',content: 'تم صدور حلقة جديدة من ون بيس',date: 'منذ ساعتين'),

];
@provide
class NotificationRepository{


  Future<List<NotificationModel>> getNotifications() async{
    await Future.delayed(Duration(milliseconds: 2000));

    return notifications;
  }

}