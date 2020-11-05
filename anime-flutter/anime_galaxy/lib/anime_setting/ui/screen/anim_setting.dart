

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

        body:
        SingleChildScrollView(
          child: Column(
            children: [

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        image: DecorationImage(
                            image: NetworkImage('https://i.pinimg.com/236x/ec/e4/b0/ece4b097f87bd6a79d8e05cfd45d17d6--matte-painting-digital-paintings.jpg'),
                            fit: BoxFit.cover),

                      ),
                      child:  Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          color: Colors.black.withOpacity(0.25),

                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: CircularImage(width: hight/8,height: hight/8,linkImg: 'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=60 200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=60 300w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60 400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60 500w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60 600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60 700w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60 800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60 900w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60 1000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=60 1100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1200&q=60 1200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60 1296w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60 1400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=60 1600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1800&q=60 1800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2000&q=60 2000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2200&q=60 2200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2400&q=60 2400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2592&q=60 2592w',)),

                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(



                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [

                      Text("محمد الكلاليب",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                      Text("مغامرات - مغامرات",style: TextStyle(fontSize: 16),)
                    ],

                  ),
//                  CustomeButton(textStyle: StyleSetting.getTextSyle(day: false),txt: "تعديل",),
                  ButtonTheme(
                    height: 50,
                    child: FlatButton(
                      color:ProjectColors.ThemeColor,
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                      //TODO : implement this
                      onPressed: (){},
                      child:Text(
                        S.of(context).edit,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        ),
                      ) ,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(icon:  Icon(Icons.notifications, size: 16,),onPressed: (){},),
                  Expanded(child: Text(S.of(context).notifications,textAlign: TextAlign.start,style:  StyleSetting.getTextSyle(day: true),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(icon:  Icon(Icons.settings, size: 16, ),onPressed: (){},),
                  Expanded(child: Text(S.of(context).genaeralSettings,textAlign: TextAlign.start,style: StyleSetting.getTextSyle(day: true),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(icon:  Icon(Icons.person, ),onPressed: (){},),
                  Expanded(child: Text(S.of(context).account,textAlign: TextAlign.start,style: StyleSetting.getTextSyle(day: true),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(icon:  Icon(Icons.work, size: 16, ),onPressed: (){},),
                  Expanded(child: Text(S.of(context).privacy,textAlign: TextAlign.start,style: StyleSetting.getTextSyle(day: true),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(icon:  Icon(Icons.help, size: 16,),onPressed: (){},),
                  Expanded(child: Text(S.of(context).help,textAlign: TextAlign.start,style: StyleSetting.getTextSyle(day: true),)),

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



