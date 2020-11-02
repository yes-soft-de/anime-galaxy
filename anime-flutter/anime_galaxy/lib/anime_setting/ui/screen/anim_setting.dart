

import 'package:anime_galaxy/anime_setting/ui/style_app.dart';
import 'package:anime_galaxy/anime_setting/ui/widget/circular_setting/circular_image.dart';
import 'package:anime_galaxy/anime_setting/ui/widget/custome_button/custome_button.dart';
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';



import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class AnimSetting extends StatefulWidget {


  final StyleSetting styleApp;

  AnimSetting(this.styleApp);

  @override
  _AnimSettingState createState() => _AnimSettingState();
}

class _AnimSettingState extends State<AnimSetting> {

  @override
  void initState() {
    super.initState();
/*    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });*/
  }


/*  void processEvent() {
    if (currentState is SettingAnimeStateFetchingSuccess) {
      SettingAnimeStateFetchingSuccess state = currentState;
      animes = state.data;

      if(this.mounted){
        setState(() {});
      }
    }


  }*/

  @override
  Widget build(BuildContext context) {
/*

    if (currentState is SettingAnimeStateInit) {
      widget._stateManager.getShows();
      if(this.mounted){
        setState(() {});
      }



    }

    return listSetting();
*/




    double hight=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ProjectColors.bgSignUpDark,
        appBar: AppBar(
          backgroundColor:ProjectColors.bgIconDay,

          elevation: 0,
          centerTitle: false,

          title:  Row(mainAxisSize: MainAxisSize.min
            ,children: [

              CircularImage(linkImg: "https://www.lamsahfannan.com/content/uploads/2017/03/3dlat.net_08_15_258a_6.jpg",
                width: hight/18,height: hight/18,),
              SizedBox(width: 10,),
              Flexible(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("مرحبا",style: StyleSetting.getTextSyle(day: false,size: 14),),
                  Text("صباح الخير",style: StyleSetting.getTextSyle(day: false,size: 14),),
                ],
              ),)
            ],),


          actions: [
            IconButton(icon: Icon(Icons.search,color: Colors.white,),onPressed: (){},),
            IconButton(icon: Icon(Icons.notifications,color: Colors.white,),onPressed: (){},),
          ],
        ),
        body:
        SingleChildScrollView(
          child: Column(
            children: [

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        image: DecorationImage(
                            image: NetworkImage("https://www.lamsahfannan.com/content/uploads/2017/03/3dlat.net_08_15_258a_6.jpg"),
                            fit: BoxFit.cover),

                      ),
                      child:  Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          color: Colors.black.withOpacity(0.25),

                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: CircularImage(width: hight/8,height: hight/8,linkImg: "https://www.lamsahfannan.com/content/uploads/2017/03/3dlat.net_08_15_258a_6.jpg",)),

                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [



                  CustomeButton(textStyle: StyleSetting.getTextSyle(day: false),txt: "تعديل",),

                  Column(



                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [

                      Text("محمد الكلاليب",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 14),),
                      Text("مغامرات - مغامرات",style: TextStyle(color: Colors.white,fontSize: 14),)
                    ],

                  ),





                ],
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(icon:  Icon(Icons.notifications,color: Colors.white,),onPressed: (){},),
                  Expanded(child: Text(S.of(context).notifications,textAlign: TextAlign.start,style:  StyleSetting.getTextSyle(day: false),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(icon:  Icon(Icons.edit,color: Colors.white,),onPressed: (){},),
                  Expanded(child: Text(S.of(context).genaeralSettings,textAlign: TextAlign.start,style: StyleSetting.getTextSyle(day: false),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(icon:  Icon(Icons.person,color: Colors.white,),onPressed: (){},),
                  Expanded(child: Text(S.of(context).account,textAlign: TextAlign.start,style: StyleSetting.getTextSyle(day: false),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(icon:  Icon(Icons.work,color: Colors.white,),onPressed: (){},),
                  Expanded(child: Text(S.of(context).privacy,textAlign: TextAlign.start,style: StyleSetting.getTextSyle(day: false),)),

                ],
              ),


            ],
          ),
        )

        /* ListView.builder(
            itemCount: animes.length,
            itemBuilder: (BuildContext context,int index){

              SettingModel item=animes.elementAt(index);

              return    CardSetting(desc: item.description,name: item.name,icon:item.icon,press: (){},);
            })*/
        /* Column(
          mainAxisSize: MainAxisSize.min,
          children: [


            CardSetting(desc: "Me",name: "hassan",icon: Icon(Icons.edit,color: Colors.white,),),
            CardSetting(desc: "Me",name: "hassan",icon: Icon(Icons.edit,color: Colors.white,),),
            CardSetting(desc: "Me",name: "hassan",icon: Icon(Icons.edit,color: Colors.white,),)


          ],
        )*/,
      ),
    );
  }

  }



