 import 'package:anime_galaxy/generated/l10n.dart';
import 'package:flutter/material.dart';

class SeriesCard extends StatelessWidget {
  final String image;
  final String name;

  SeriesCard({
    this.name,
    this.image
  });

  @override
  Widget build(BuildContext context) {
    return   Container(

          height: 150,
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,

                margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                 height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(image),
                  ),
                ),

//
              ),
              Container(
                height: 20,
                child: Center(
                    child: Text(
                     name??'',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily:'Roboto',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,

                      ),
                    )
                ),
              ),




            ],
          )
      ) ;
  }
}
