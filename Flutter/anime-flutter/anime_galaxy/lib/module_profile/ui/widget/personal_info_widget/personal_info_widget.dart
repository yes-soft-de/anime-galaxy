import 'package:anime_galaxy/generated/l10n.dart';
import 'package:flutter/material.dart';

class PersonalInfoWidget extends StatelessWidget {
  final String name;
  final String category;
  final String followingNumber;
  final String seriesNumber;
  final String commentsNumber;
  final String image;
  final String createDate;

  PersonalInfoWidget({
    this.name,
    this.image,
    this.followingNumber,
    this.seriesNumber,
    this.category,
    this.commentsNumber,
    this.createDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 130,
            height: 155,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                       '$name',
                       style: TextStyle(
                           fontSize: 16,
                           fontFamily:'Roboto',
                           fontWeight: FontWeight.bold
                       ),
                     ),
                     Text(
                       '$createDate',
                       style: TextStyle(
                           fontSize: 14,
                           fontFamily:'Roboto',
                       ),
                     ),
                   ],
                 ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '$category',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily:'Roboto',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff7e7f9a),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  S.of(context).comments,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily:'Roboto',
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '$commentsNumber',
                                  style: TextStyle(
                                    fontFamily:'Roboto',
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  S.of(context).following,
                                  style: TextStyle(
                                    fontFamily:'Roboto',
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '$followingNumber',
                                  style: TextStyle(
                                    fontFamily:'Roboto',
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  S.of(context).series,
                                  style: TextStyle(
                                    fontFamily:'Roboto',
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '$seriesNumber',
                                  style: TextStyle(
                                    fontFamily:'Roboto',
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
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
