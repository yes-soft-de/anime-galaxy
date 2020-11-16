import 'package:anime_galaxy/generated/l10n.dart';
import 'package:flutter/material.dart';

class EpisodeCard extends StatelessWidget {
  final String image;
  final int episodeNumber;
  final String classification;

  EpisodeCard({this.episodeNumber, this.classification, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        height: 160,
        child: Column(
          children: [
            FadeInImage.assetNetwork(
              width: MediaQuery.of(context).size.width,
              height: 110,
              placeholder: 'assets/images/logo.jpg',
              image: image,
              fit: BoxFit.fill,
            ),
            Container(
              height: 5,
            ),
            Center(
                child: Text(
              S.of(context).Episode + ' $episodeNumber ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )),
            Text(
              classification,
              style: TextStyle(fontSize: 9, color: Colors.black38),
            ),
          ],
        ));
  }
}
