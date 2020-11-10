
import 'package:anime_galaxy/module_explore/style/style_explore_list.dart';
import 'package:flutter/material.dart';

class SeriesCard extends StatelessWidget {
  final String url_image;
  final String series_name;
  final String series_category;




  SeriesCard({this.url_image, this.series_name, this.series_category});

  @override
  Widget build(BuildContext context) {
    return  Container(

      width: 140,
      height: 220,
      child: Column(

        children: [
          Container(
            height: 140,
            child: Card (
              child: Image.network('${url_image}',
                fit: BoxFit.cover,width: 140,),
              elevation: 0,

              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Text(
                  '${series_name}',
                  style: StyleExploreList.getTextSyle(size: 12,fontWeight: FontWeight.w400,day:true),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${series_category}',
                  style: StyleExploreList.getTextSyle(size: 12,day:true),
                   overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
