import 'package:anime_galaxy/anime_explor_list/model/AllAnimeData.dart';
import 'package:anime_galaxy/anime_explor_list/state/anime_explore_list_state.dart';
import 'package:anime_galaxy/anime_explor_list/state_manager/anime_explore_list_state_manager.dart';
import 'package:anime_galaxy/anime_explor_list/style_explore_list.dart';
import 'package:anime_galaxy/anime_explor_list/ui/widget/card_members/card_series.dart';
import 'package:anime_galaxy/anime_explor_list/ui/widget/card_series/card_series.dart';
import 'package:anime_galaxy/anime_explor_list/ui/widget/card_series_favorite/card_series.dart';
import 'package:anime_galaxy/anime_explor_list/ui/widget/circular_image/circular_image.dart';
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inject/inject.dart';



@provide
class AnimeExploreList extends StatefulWidget {
  final StyleExploreList styleApp;

  final AnimeExplorListStateManager _stateManager;


  AnimeExploreList(this.styleApp,this._stateManager);

  @override
  _ExploreListState createState() => _ExploreListState();
}

class _ExploreListState extends State<AnimeExploreList> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<AllAnimeData> animes = [];
  AnimeExplorListState currentState = AnimeExplorListStateInit();




  @override
  void initState() {
    super.initState();

    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent() {
    if (currentState is AnimeExplorListStateFetchingSuccess) {
      AnimeExplorListStateFetchingSuccess state = currentState;
      animes = state.data;

      if(this.mounted){
        setState(() {});
      }
    }


  }


  @override
  Widget build(BuildContext context) {
    double hight=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    print("begin");
    if (currentState is AnimeExplorListStateInit) {
      print("begin after");
      widget._stateManager.getShows();
      if(this.mounted){
        setState(() {});
      }



    }

    return data(context,hight,width);
  }


  Widget data(BuildContext context,double hight,double width){

    return SafeArea(

      child: Scaffold(
        backgroundColor: ProjectColors.bgSignUpDark,
        key: _drawerKey,
        appBar: AppBar(
          backgroundColor:ProjectColors.bgSignUpDark,

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
                  Text("مرحبا",style: StyleExploreList.getTextSyle(day: false,size: 14),),
                  Text("صباح الخير",style: StyleExploreList.getTextSyle(day: false,size: 14),),
                ],
              ),)
            ],),


          actions: [
            IconButton(icon: Icon(Icons.search,color: Colors.white,),onPressed: (){},),
            IconButton(icon: Icon(Icons.notifications,color: Colors.white,),onPressed: (){},),
          ],
        ),
        body: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(



              mainAxisSize: MainAxisSize.min,
              children: [



                SizedBox(width: 8,),
                Row(
                  children: [
                    Expanded(
                      child: Text(S.of(context).worldWideSeries,style: StyleExploreList.getTextSyle(size: 16,fontWeight: FontWeight.w500,
                        day: false,),),
                    ),
                  ],
                ),
                Container(

                  height: 200,
                  child: ListView.builder(itemBuilder: (context,index){
                    AllAnimeData item=animes.elementAt(index);
                    return   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: CardSeries(url_image: 'https://www.lamsahfannan.com/content/uploads/2017/03/3dlat.net_08_15_258a_6.jpg',

                        series_category: '${item.categoryName}',

                        series_name:'${item.name}',),
                    );
                  },
                    itemCount:animes.length ,


                    scrollDirection: Axis.horizontal,),
                ),

                Divider(height: 1,thickness: 0.1,color: Colors.grey,),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: Text(S.of(context).recomendationByFavorite,style: StyleExploreList.getTextSyle(size: 16,fontWeight: FontWeight.w500,
                        day: false,),),
                    ),
                  ],
                ),
                Container(

                  height: 200,
                  child: ListView.builder(itemBuilder: (context,index){
                    return   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CardSeriesFavorite(url_image: "https://www.lamsahfannan.com/content/uploads/2017/03/3dlat.net_08_15_258a_6.jpg",
                        series_category: "category",
                        series_name: "name",),
                    );
                  },
                    itemCount:4 ,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,),
                ),
                SizedBox(height: 10,),
                Divider(height: 1,thickness: 0.1,color: Colors.grey,),

                SizedBox(height: 10,),

                Row(
                  children: [
                    Expanded(
                      child: Text(S.of(context).activeMembers,style: StyleExploreList.getTextSyle(size: 16,fontWeight: FontWeight.w500,
                        day: false,),),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Container(

                  height: 100,
                  child: ListView.builder(itemBuilder: (context,index){
                    return   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CardMembers(url_image: 'https://www.lamsahfannan.com/content/uploads/2017/03/3dlat.net_08_15_258a_6.jpg',
                        series_name: 'name',),
                    );
                  },
                    itemCount:4 ,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,),
                ),
              ],

            ),
          ),
        ),

      ),
    );
  }
}
