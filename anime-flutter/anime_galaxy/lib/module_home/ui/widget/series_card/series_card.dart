import 'package:flutter/material.dart';

class SeriesCard extends StatelessWidget {
  final String image;
  final String name;
  final String classification;

  SeriesCard({this.name, this.classification, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        height: 200,
        width: 110,
        child: Column(
          children: [
            Container(
              width: 110,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image:  NetworkImage(image ??
                      'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d'
                  ),
                ),
              ),
            ),


            Container(
              height: 5,
            ),
            Center(
                child: Text(
                  '$name',
                  textDirection: TextDirection.rtl,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily:'Roboto',
                      fontWeight: FontWeight.bold
                  ),
                )),
            Text(
              classification??'',
              style: TextStyle(
                  fontSize: 12,
                  fontFamily:'Roboto',
                  color: Colors.black38
              ),
            ),
          ],
        ));
  }
}
