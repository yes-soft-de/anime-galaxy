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
        height: 120,
        width: 90,
        child: Column(
          children: [
            FadeInImage.assetNetwork(
              height: 90,
              placeholder: 'assets/images/logo.jpg',
              image: image,
              fit: BoxFit.fill,
            ),
            Container(
              height: 5,
            ),
            Center(
                child: Text(
              '$name',
              textDirection: TextDirection.rtl,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            )),
            Text(
              classification,
              style: TextStyle(fontSize: 12, color: Colors.black38),
            ),
          ],
        ));
  }
}
