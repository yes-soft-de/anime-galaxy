import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:flutter/material.dart';

typedef FollowCallBack = void Function();
typedef UnFollowCallBack = void Function();
typedef LoveCallBack = void Function();

class AnimeDetailsWidget extends StatelessWidget {
  final String name;
  final String showYear;
  final String likes;
  final int comments;
  final String image;
  final FollowCallBack onFollow;
  final UnFollowCallBack onUnFollow;
  final bool isFollowed;
  final bool isLoved;
  final int episodesNumber;
  final LoveCallBack onLove;
  final String ageGroup;

  AnimeDetailsWidget({
    this.name,
    this.likes,
    this.showYear,
    this.comments,
    this.image,
    this.isFollowed,
    this.isLoved,
    this.onFollow,
    this.onUnFollow,
    this.episodesNumber,
    this.onLove,
    this.ageGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 136,
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                image: image ?? '',
                placeholder: 'assets/images/logo.jpg',
                width: 80,
              ),
              elevation: 0,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily:'Roboto',
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      showYear ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily:'Roboto',
                      ),
                    ),


                  ],
                ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          ageGroup ?? '',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily:'Roboto',
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '$episodesNumber حلقة',
                              style: TextStyle(
                                fontSize: 13,
                                color: ProjectColors.ThemeColor,
                                fontFamily:'Roboto',
                              ),
                            )
                          ],
                        ),

                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '$comments',
                                  style: TextStyle(
                                    fontFamily:'Roboto',
                                    fontSize: 13
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(Icons.comment,
                                    color: ProjectColors.ThemeColor)
                              ],
                            ),

                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '$likes',
                                  style: TextStyle(
                                    fontFamily:'Roboto',
                                    fontSize: 13
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                ImageIcon(
                                  AssetImage('assets/images/full_flame.png'),
                                  color: ProjectColors.ThemeColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonTheme(
                          height: 12,
                          child: FlatButton(
                            color: isFollowed
                                ? Colors.grey
                                : ProjectColors.ThemeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            onPressed: isFollowed ? onUnFollow : onFollow,
                            child: Text(
                              isFollowed
                                  ? S.of(context).unFollow
                                  : S.of(context).Follow,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily:'Roboto',
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon:isLoved? ImageIcon(
                                AssetImage('assets/images/full_flame.png'),
                                color: ProjectColors.ThemeColor,
                              ):
                              ImageIcon(
                                AssetImage('assets/images/flame.png'),
                                color: ProjectColors.ThemeColor,
                              )
                              ,

                              onPressed: isLoved?(){}: onLove ,
                            ),
                            Text(
                              S.of(context).Like,
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily:'Roboto',
                              ),
                            ),
//                            IconButton(
//                              icon: Icon(Icons.share),
//                              //TODO : implement this
//                              onPressed: () {},
//                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
