import 'package:anime_galaxy/module_notification/ui/widget/notification_card/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<int> notifications = [1,1,1,1,11,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
  @override
  Widget build(BuildContext context) {
    return getPageLayout();
  }

  Widget getPageLayout(){
    return Scaffold(
      //TODO : replace the appbar with the proper one
      appBar: AppBar(title: Text('Anime'),),
      body: Container(
        child: ListView.builder(
             itemCount: notifications.length,
            padding: EdgeInsetsDirectional.fromSTEB(10,20 ,10, 10),
            itemBuilder: (BuildContext context,int index){
              return Container(
                margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: NotificationCard(
                    image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
                    content: 'تم صدور حلقة جديدة من ون بيس',
                    date: 'منذ ساعتين',
                  )
              );
            }),
      ),
    );
  }
}
