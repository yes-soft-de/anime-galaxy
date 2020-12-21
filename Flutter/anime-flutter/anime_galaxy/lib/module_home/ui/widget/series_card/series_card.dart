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
        height: 170,
        width: 110,
        child: Column(
          children: [
            Container(
              height: 150,
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  image: image ?? '',
                  placeholder: 'assets/images/logo.jpg',
                  width: 100,
                ),
                elevation: 0,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
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

          ],
        ));
  }
}
