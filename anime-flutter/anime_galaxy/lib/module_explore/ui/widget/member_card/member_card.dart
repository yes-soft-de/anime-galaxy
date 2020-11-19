 import 'package:anime_galaxy/anime_setting/ui/widget/circular_setting/circular_image.dart';
import 'package:anime_galaxy/module_explore/style/style_explore_list.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final String url_image;
  final String series_name;





  MemberCard({this.url_image, this.series_name});

  @override
  Widget build(BuildContext context) {
    return  Container(

      width: 72,
      height: 72,
      child: Column(

        children: [

          Container(alignment: Alignment.center,child: CircularImage(width: 70,height: 70,linkImg: url_image,)),

          SizedBox(height: 4,),

          Row(

            children: [
              Expanded(
                child: Text('${series_name}',
                  style: StyleExploreList.getTextSyle(
                      size: 14,
                      fontWeight: FontWeight.w400,
                      day:true
                  ),
                  maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
