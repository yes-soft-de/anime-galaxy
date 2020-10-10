import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';



class CardSetting extends StatelessWidget {
  VoidCallback press;
  String name;
  String desc;
  Widget icon;


  CardSetting({this.press, this.name, this.desc, this.icon});

  @override
  Widget build(BuildContext context) {
    return   Card(
      color: ProjectColors.bgCardSettingColor,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide.none,

      ),

      clipBehavior: Clip.hardEdge,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),

        child: Row(
          children: [

            IconButton(icon:icon,onPressed:press,),

            SizedBox(width: 10,),
            Expanded(flex: 2,child: Text("$desc",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),
                textAlign: TextAlign.start)),

            Flexible(
              child: Text("$name",style: TextStyle(color: Colors.white,fontSize: 14),
                  textAlign: TextAlign.start),
            )
          ],
        ),
      ),


    );
  }
}
