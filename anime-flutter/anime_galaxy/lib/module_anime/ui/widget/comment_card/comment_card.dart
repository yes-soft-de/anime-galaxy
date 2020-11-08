import 'package:flutter/material.dart';
class CommentCard extends StatelessWidget {
  final String userImage;
  final String comment;
  final String date;
  final String userName;

  CommentCard({
   this.comment,
   this.date,
   this.userImage,
   this.userName,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:NetworkImage(userImage),
                    ),
                  ),

                  Text(
                    userName,
                    style: TextStyle(
                        fontSize: 10
                    ),
                  ),

                ],
              ),
              Text(
                  date,
                style: TextStyle(
                  fontSize: 8
                ),
              ),

            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.8,
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Text(
              comment,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: 10
              ),
            ),
          )
        ],
      ),
    );
  }
}
