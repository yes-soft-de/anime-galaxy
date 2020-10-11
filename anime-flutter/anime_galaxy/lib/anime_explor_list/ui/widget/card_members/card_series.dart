import 'package:anime_galaxy/anime_explor_list/ui/widget/circular_image/circular_image.dart';
import 'package:flutter/material.dart';

import '../../../style_explore_list.dart';

class CardMembers extends StatelessWidget {
  String url_image;
  String series_name;





  CardMembers({this.url_image, this.series_name});

  @override
  Widget build(BuildContext context) {
    return  Container(

      width: 90,

      child: Column(

        children: [

          Container(alignment: Alignment.center,child: CircularImage(width: 60,height: 60,linkImg: url_image,)),

          SizedBox(height: 4,),

          Row(

            children: [
              Expanded(
                child: Text("${series_name}",style: StyleExploreList.getTextSyle(size: 14,fontWeight: FontWeight.w400,day:false),
                  maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
