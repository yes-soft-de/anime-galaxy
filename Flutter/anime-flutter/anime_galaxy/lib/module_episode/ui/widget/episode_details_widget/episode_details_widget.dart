import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:flutter/material.dart';

typedef LoveCallBack = void Function();

class EpisodeDetailsWidget extends StatelessWidget {
  final String name;
  final String showYear;
  final String rate;
  final String likes;
  final int comments;
  final String image;
  final LoveCallBack onLove;
  final bool isLoved;
  final String duration;

  EpisodeDetailsWidget(
      {this.name,
        this.likes,
        this.rate,
        this.showYear,
        this.comments,
        this.image,
        this.onLove,
        this.isLoved,
        this.duration,
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
                    name,
                    style: TextStyle(
                      fontFamily:'Roboto',
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      showYear,
                      style: TextStyle(
                        fontFamily:'Roboto',
                      ),
                    ),
                    Text(
                      duration,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily:'Roboto',
                      ),
                    ),
                  ],
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            rate != null
                                ? ((double.parse(rate) * 10).floor() / 10)
                                .toString()
                                : 0.toString(),
                            style: TextStyle(
                              fontFamily:'Roboto',
                            ),
                          ),
                          Icon(Icons.star_border,
                              color: ProjectColors.ThemeColor)
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
                                ),
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
                                ),
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
                  Row(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: isLoved?  ImageIcon(

                              AssetImage('assets/images/full_flame.png'),
                              color: ProjectColors.ThemeColor,
                            ):
                            ImageIcon(

                              AssetImage('assets/images/flame.png'),
                              color: ProjectColors.ThemeColor,
                            )
                            ,
                            onPressed:  isLoved?(){}: onLove,
                          ),
                          Text(
                            S.of(context).Like,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily:'Roboto',
                            ),
                          ),
                        ],
                      ),
//                      Row(
//                        children: [
//                          IconButton(
//                            icon: Icon(Icons.share),
//                            //TODO : implement this
//                            onPressed: () {},
//                          ),
//                          Text(
//                            S.of(context).Share,
//                            style: TextStyle(
//                              fontSize: 10,
//                              fontFamily:'Roboto',
//                            ),
//                          ),
//                        ],
//                      ),
                    ],
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
