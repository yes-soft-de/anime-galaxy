import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_notification/model/notification_model/notification_model.dart';
import 'package:anime_galaxy/module_notification/state/notification/notification.state.dart';
import 'package:anime_galaxy/module_notification/state_manager/notification/notification.state_manager.dart';
import 'package:anime_galaxy/module_notification/ui/widget/notification_card/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class NotificationScreen extends StatefulWidget {
  final NotificationStateManager _stateManager;

  NotificationScreen(this._stateManager);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications;
  NotificationState currentState = new NotificationStateInit();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent() {
    if (currentState is NotificationStateFetchingSuccess) {
      NotificationStateFetchingSuccess state = currentState;
      notifications = state.data;
      loading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentState is NotificationStateInit) {
      widget._stateManager.getNotifications();
      if (this.mounted) {
        setState(() {});
      }
    }

    return getPageLayout();
  }

  Widget getPageLayout() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child:
        notifications.isEmpty ?
        Container(
          child: Center(
              child: Text(S.of(context).noNotificationsYet)
          ),
        )
              :
        ListView.builder(
            itemCount: notifications.length,
            padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
            itemBuilder: (BuildContext context, int index) {
               return Container(
              margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: NotificationCard(
                  image: notifications[index].image,
                  content: notifications[index].content,
                  date: notifications[index].date,
              )
              );

            }),
      ),
    );
  }
}
