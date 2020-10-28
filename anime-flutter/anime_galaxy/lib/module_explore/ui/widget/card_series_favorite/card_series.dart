
import 'package:anime_galaxy/module_explore/style/style_explore_list.dart';
import 'package:flutter/material.dart';

class CardSeriesFavorite extends StatelessWidget {
  String url_image;
  String series_name;
  String series_category;




  CardSeriesFavorite({this.url_image, this.series_name, this.series_category});

  @override
  Widget build(BuildContext context) {
    return  Container(

      width: 110,

      child: Column(

        children: [
          Container(
            height: 160,
            child: Card (
              clipBehavior: Clip.hardEdge,
              child: Image.network("${url_image}",
                fit: BoxFit.cover,width: 110,),
              elevation: 0,

              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Text("${series_name}",style: StyleExploreList.getTextSyle(size: 14,fontWeight: FontWeight.w400,day:false),
                  maxLines: 1,overflow: TextOverflow.ellipsis,),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text("${series_category}",style: StyleExploreList.getTextSyle(size: 14,day:false),
                  maxLines: 1,overflow: TextOverflow.ellipsis,),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
