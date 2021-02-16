
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';

class AnimeCardWidget extends StatelessWidget {
  final String name;
  final String category;
  final String image;
  final String rating;
  final int comments;
  final int episodesCount;
  final String generalRating;
  final String ageGroup;
  final int likes;

  AnimeCardWidget({
    this.name,
    this.image,
    this.category,
    this.rating,
    this.generalRating,
    this.episodesCount,
    this.comments,
    this.ageGroup,
    this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(15),
        color: Colors.black12,
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(image ??
                    'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Text(
                          '$name',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily:'Roboto',
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
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
                            '$episodesCount  حلقة',
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).generalEvaluation,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily:'Roboto',
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              rating != null
                                  ? ((double.parse(rating) * 10).floor() / 10)
                                  .toString()
                                  : 0.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily:'Roboto'
                              ),
                            ),
                            Icon(Icons.star_border,
                                color: ProjectColors.ThemeColor),
                          ],
                        )

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'MAL',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily:'Roboto',
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              generalRating != null
                                  ? ((double.parse(generalRating) * 10).floor() / 10)
                                  .toString()
                                  : 0.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily:'Roboto'
                              ),
                            ),
                            Icon(Icons.star_border,
                                color: ProjectColors.ThemeColor),
                          ],
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
