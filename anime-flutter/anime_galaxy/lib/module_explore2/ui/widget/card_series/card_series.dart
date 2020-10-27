
import 'package:anime_galaxy/module_explore2/style/style_explore_list.dart';
import 'package:flutter/material.dart';

class CardSeries extends StatelessWidget {
  String url_image;
  String series_name;
  String series_category;




  CardSeries({this.url_image, this.series_name, this.series_category});

  @override
  Widget build(BuildContext context) {
    return  Container(

      width: 150,

      child: Column(

        children: [
          Container(
            height: 140,
            child: Card (
              child: Image.network("${url_image}",
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
