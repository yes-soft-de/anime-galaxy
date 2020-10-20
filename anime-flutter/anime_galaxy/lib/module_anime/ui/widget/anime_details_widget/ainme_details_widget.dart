 import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:flutter/material.dart';

class AnimeDetailsWidget extends StatelessWidget {
  final String name;
  final String showYear;
  final double rate;
  final String likes;
  final int comments;
  final String image;

  AnimeDetailsWidget({
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
            width: MediaQuery.of(context).size.width*0.75,
            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  textDirection: TextDirection.rtl,
                ),
                Text( showYear,
                  textDirection: TextDirection.rtl,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          S.of(context).Share,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 10
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: (){},
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          S.of(context).Like,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 10
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: (){},
                        )
                      ],
                    ),

                      ButtonTheme(
                        height: 10,
                        child: FlatButton(
                          color:ProjectColors.ThemeColor,
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),

                          onPressed: () {},
                          child:Text(
                            S.of(context).Follow,
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white
                            ),
                          ) ,
                        ),
                      ),

                  ],
                )
              ],
            ),
          ),
            Container(
              width: MediaQuery.of(context).size.width*0.22,

              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child:  Image(
                  image: NetworkImage(image),


              ),
              ),
            ),

        ],
      ),
    );
  }
}
