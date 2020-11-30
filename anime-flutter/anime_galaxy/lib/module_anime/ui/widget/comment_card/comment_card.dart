import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';

typedef LoveCommentCallBack = void Function();

class CommentCard extends StatelessWidget {
  final String userImage;
  final String comment;
  final String date;
  final String userName;
  final String likesNumber;
  final bool isLoved;
  final LoveCommentCallBack onLove;

  CommentCard({
    this.comment,
    this.date,
    this.userImage,
    this.userName,
    this.likesNumber,
    this.onLove,
    this.isLoved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(userImage),
                      ),
                    ),
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily:'Roboto',
                    ),
                  ),
                ],
              ),
              Text(
                date,
                style: TextStyle(
                  fontFamily:'Roboto',
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container
                (
                width: MediaQuery.of(context).size.width * 0.6,
                padding: EdgeInsetsDirectional.fromSTEB(60, 10, 0, 0),
                child: Text(
                  '$comment',
                  style: TextStyle(
                      fontFamily:'Roboto',
                      fontSize: 16
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: isLoved ?(){}: onLove,
                    icon: isLoved?
                    ImageIcon(
                      AssetImage('assets/images/full_flame.png'),
                      color: ProjectColors.ThemeColor,
                    ) :
                    ImageIcon(
                      AssetImage('assets/images/flame.png'),
                      color: ProjectColors.ThemeColor,
                    )
                    ,
                  ),
                  Text(
                    '${likesNumber??0}',
                    style: TextStyle(
                        fontFamily:'Roboto',
                        fontSize: 12
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
