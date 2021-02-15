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
        height: 200,
        width: 110,
        child: Column(
          children: [
            Container(
              height: 145,
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
              S.of(context).Episode + ' $episodeNumber ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily:'Roboto',
              ),
            )),
            Text(
              classification??'',
              style: TextStyle(
                  fontSize: 9,
                  fontFamily:'Roboto',
                  color: Colors.black38
              ),
            ),
          ],
        ));
  }
}
