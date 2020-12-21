 import 'package:anime_galaxy/generated/l10n.dart';
import 'package:flutter/material.dart';

class SeriesCard extends StatelessWidget {
  final String image;
  final String name;
  final String classification;

  SeriesCard({
    this.name,
    this.classification,
    this.image
  });

  @override
  Widget build(BuildContext context) {
    return   Container(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),

          height: 160,
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,

                margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                 height: 100,
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
                   name,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontFamily:'Roboto',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,

                    ),
                  )
              ),

                    Text(
                      classification,
                      style: TextStyle(
                          fontFamily:'Roboto',
                          fontSize: 9,
                        color: Colors.black38
                      ),
                    ),



            ],
          )
      ) ;
  }
}
