import 'dart:io';

import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final double width;
  final double height;
  final String linkImg;
  final File fileImg;


  CircularImage({this.width, this.height,this.linkImg,this.fileImg});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(

      border: Border.all(
        width: 1,
        color: Colors.grey
      ),
      borderRadius: BorderRadius.circular(100)

    ),
      width: width,
      height: height,
      child: ClipOval(child:
          linkImg!=null?
      Image.network(linkImg,fit: BoxFit.cover,):fileImg!=null? Image.file(fileImg):Container(
            color: Colors.blue,
          )
    ));
  }
}
