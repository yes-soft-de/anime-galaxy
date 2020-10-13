 import 'package:anime_galaxy/generated/l10n.dart';
import 'package:flutter/material.dart';

class EpisodeCard extends StatelessWidget {
  final String image;
  final int episodeNumber;
  final String classification;

  EpisodeCard({
    this.episodeNumber,
    this.classification,
    this.image
  });

  @override
  Widget build(BuildContext context) {
    return   Container(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),

          height: 160,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,

                margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                 height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(image),
                  ),
                ),

//
              ),
              Center(

                  child: Text(
                   '$episodeNumber'+ S.of(context).Episode ,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),

                    Text(
                      classification,
                      style: TextStyle(
                          fontSize: 9,
                        color: Colors.black38
                      ),
                    ),



            ],
          )
      ) ;
  }
}
