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

          height: 120,
          width: 90,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,

                margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                 height: 90,
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
                     '$name',
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),

                    Text(
                      classification,
                      style: TextStyle(
                          fontSize: 12,
                        color: Colors.black38
                      ),
                    ),



            ],
          )
      ) ;
  }
}
