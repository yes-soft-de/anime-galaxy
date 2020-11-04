 import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:flutter/material.dart';

class EpisodeDetailsWidget extends StatelessWidget {
  final String name;
  final String showYear;
  final double rate;
  final String likes;
  final int comments;
  final String image;

  EpisodeDetailsWidget({
   this.name,
    this.likes,
    this.rate,
    this.showYear,
    this.comments,
    this.image
});
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.22,

            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child:  FadeInImage.assetNetwork(placeholder:'' , image: image)

            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.75,
            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,

                ),
                Text( showYear,

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                            '$rate'
                        ),
                        Icon(
                            Icons.star_border,
                            color:ProjectColors.ThemeColor
                        )
                      ],
                    ),
                    Row(

                      children: [
                        Row(
                          children: [
                            Text(
                                '$likes'
                            ),
                            Icon(
                                Icons.favorite,
                                color:ProjectColors.ThemeColor
                            )
                          ],
                        ),
                        SizedBox(width: 10,),
                        Row(
                          children: [
                            Text(
                                '$comments'
                            ),
                            Icon(
                                Icons.comment,
                                color:ProjectColors.ThemeColor
                            )
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
                          icon: Icon(Icons.favorite),
                          //TODO : implement this
                          onPressed: (){},
                        ),
                        Text(
                          S.of(context).Like,

                          style: TextStyle(
                              fontSize: 10
                          ),
                        ),

                      ],
                    ),
                    Row(
                      children: [

                        IconButton(
                          icon: Icon(Icons.share),
                          //TODO : implement this
                          onPressed: (){},
                        ),
                        Text(
                          S.of(context).Share,

                          style: TextStyle(
                              fontSize: 10
                          ),
                        ),
                      ],
                    ),


                  ],
                )
              ],
            ),
          ),


        ],
      ),
    );
  }
}
