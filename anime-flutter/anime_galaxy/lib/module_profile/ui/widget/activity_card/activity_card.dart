import 'package:flutter/material.dart';
class ActivityCard extends StatelessWidget {
  final String userImage;
  final String activity;
  final String date;
  final String userName;

  ActivityCard({
    this.activity,
    this.date,
    this.userImage,
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(15)
      ),
      width: MediaQuery.of(context).size.width*0.9,
      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

             Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:NetworkImage('$date'),
                    ),
                  ),

              Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: Text(
                  'قام $userName بالتعليق على المسلسل $activity',
                  style: TextStyle(
                      fontFamily:'Roboto',
                      fontSize: 10
                  ),
                ),
              ),
              Text(
                '$date',
                style: TextStyle(
                    fontFamily:'Roboto',
                    fontSize: 8
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}
