
import 'package:anime_galaxy/module_explore/style/style_explore_list.dart';
import 'package:flutter/material.dart';

class FavouriteSeriesCard extends StatelessWidget {
  final String url_image;
  final String series_name;
  final String series_category;




  FavouriteSeriesCard({this.url_image, this.series_name, this.series_category});

  @override
  Widget build(BuildContext context) {
    return  Container(

      height: 126,
       width: 88,
      child: Column(

        children: [
          Container(
            height: 115,
            child: Card (
              clipBehavior: Clip.hardEdge,
              child: Image.network("${url_image}",
                fit: BoxFit.cover,width: 88,),
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
                child: Text("${series_name}",style: StyleExploreList.getTextSyle(size: 14,fontWeight: FontWeight.w400,day:true),
                  maxLines: 1,overflow: TextOverflow.ellipsis,),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text("${series_category}",style: StyleExploreList.getTextSyle(size: 14,day:true),
                  maxLines: 1,overflow: TextOverflow.ellipsis,),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
