
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_notification/service/notification/notification.service.dart';
import 'package:anime_galaxy/module_notification/state/notification/notification.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class NotificationStateManager{
  final NotificationService _notificationService;
  final PublishSubject<NotificationState> _stateSubject = PublishSubject();
  Stream<NotificationState> get stateStream => _stateSubject.stream;


  NotificationStateManager(this._notificationService);

  void getNotifications(){
    this._stateSubject.add(NotificationStateFetching());

    this._notificationService.getNotifications().then((value) {
      if(value != null){
        this._stateSubject.add(NotificationStateFetchingSuccess(value));
      }
      else{
        this._stateSubject.add(NotificationStateFetchingError());
        Fluttertoast.showToast(msg: S.current.errorLoadingData);
      }
    });
  }
}