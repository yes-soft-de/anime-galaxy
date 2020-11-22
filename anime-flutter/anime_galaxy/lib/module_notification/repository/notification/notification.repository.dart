
import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:anime_galaxy/module_notification/response/notification_response/notification_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';


@provide
class NotificationRepository{
  final ApiClient _apiClient;
  final AuthService _authService;

  NotificationRepository(
      this._apiClient,
      this._authService,
      );


  Future<List<NotificationResponse>> getNotifications() async{
    String userId = await _authService.userID;
    dynamic response = await _apiClient.get(Urls.API_NOTIFICATION+userId);
    if (response == null ) return null;

    List<NotificationResponse> notifications =[];
    dynamic res = response['Data'];
    for(int i=0 ; i<res.length ; i++){
      notifications.add(NotificationResponse.fromJson(res[i]));
    }

    return notifications;
  }

}