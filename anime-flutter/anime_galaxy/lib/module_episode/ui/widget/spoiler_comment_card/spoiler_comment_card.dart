import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_profile/profile_routes.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';

typedef showCommentCallBack = void Function();

class SpoilerCommentCard extends StatelessWidget {
  final String userImage;
  final String date;
  final String userName;
  final String likesNumber;
  final bool isLoved;
  final showCommentCallBack onShow;
  final String userId;

  SpoilerCommentCard({
    this.date,
    this.userImage,
    this.userName,
    this.likesNumber,
    this.onShow,
    this.isLoved,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return
    Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: ()=> Navigator.pushNamed(
                    context,
                    ProfileRoutes.ROUTE_PROFILE,
                    arguments: userId
                ),
                child: Row(
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
                  S.of(context).commentContainsSpoiler,
                  style: TextStyle(
                      fontFamily:'Roboto',
                      fontSize: 14
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onShow  ,
                    icon:  Icon(
                      Icons.remove_red_eye,
                      color: ProjectColors.ThemeColor,
                    ),
                  ),

                ],
              ),
            ],
          )
        ],
      ),
    ) ;
  }
}
