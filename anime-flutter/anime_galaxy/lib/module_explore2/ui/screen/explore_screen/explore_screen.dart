 import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
   @override
   _ExploreScreenState createState() => _ExploreScreenState();
 }

 class _ExploreScreenState extends State<ExploreScreen> {
   @override
   Widget build(BuildContext context) {
     return Container();
   }

   Widget pageLayout(BuildContext context, double hight, double width) {
//
//    return SafeArea(
//
//      child: Scaffold(
//
//        key: _drawerKey,
//        appBar: AppBar(
//
//          elevation: 0,
//          centerTitle: false,
//
//
//          title:  Row(mainAxisSize: MainAxisSize.min
//            ,children: [
//
//              CircularImage(linkImg: "https://www.lamsahfannan.com/content/uploads/2017/03/3dlat.net_08_15_258a_6.jpg",
//                width: hight/18,height: hight/18,),
//              SizedBox(width: 10,),
//              Flexible(child: Column(
//                mainAxisSize: MainAxisSize.min,
//                children: [
//                  Text("مرحبا",style: StyleExploreList.getTextSyle(day: false,size: 14),),
//                  Text("صباح الخير",style: StyleExploreList.getTextSyle(day: false,size: 14),),
//                ],
//              ),)
//            ],),
//
//
//          actions: [
//            IconButton(icon: Icon(Icons.search,color: Colors.white,),onPressed: (){},),
//            IconButton(icon: Icon(Icons.notifications,color: Colors.white,),onPressed: (){},),
//          ],
//        ),
//        body: SingleChildScrollView(
//
//          child: Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 8),
//            child: Column(
//
//
//
//              mainAxisSize: MainAxisSize.min,
//              children: [
//
//
//
//                SizedBox(width: 8,),
//                Row(
//                  children: [
//                    Expanded(
//                      child: Text(S.of(context).worldWideSeries,style: StyleExploreList.getTextSyle(size: 16,fontWeight: FontWeight.w500,
//                        day: false,),),
//                    ),
//                  ],
//                ),
//                Container(
//
//                  height: 200,
//                  child: ListView.builder(itemBuilder: (context,index){
//                    AllAnimeData item=animes.elementAt(index);
//                    return   Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 2),
//                      child: CardSeries(url_image: 'https://www.lamsahfannan.com/content/uploads/2017/03/3dlat.net_08_15_258a_6.jpg',
//
//                        series_category: '${item.categoryName}',
//
//                        series_name:'${item.name}',),
//                    );
//                  },
//                    itemCount:animes.length ,
//
//
//                    scrollDirection: Axis.horizontal,),
//                ),
//
//                Divider(height: 1,thickness: 0.1,color: Colors.grey,),
//                SizedBox(height: 10,),
//                Row(
//                  children: [
//                    Expanded(
//                      child: Text(S.of(context).recomendationByFavorite,style: StyleExploreList.getTextSyle(size: 16,fontWeight: FontWeight.w500,
//                        day: false,),),
//                    ),
//                  ],
//                ),
//                Container(
//
//                  height: 200,
//                  child: ListView.builder(itemBuilder: (context,index){
//                    return   Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 4),
//                      child: CardSeriesFavorite(url_image: "https://www.lamsahfannan.com/content/uploads/2017/03/3dlat.net_08_15_258a_6.jpg",
//                        series_category: "category",
//                        series_name: "name",),
//                    );
//                  },
//                    itemCount:4 ,
//                    shrinkWrap: true,
//                    scrollDirection: Axis.horizontal,),
//                ),
//                SizedBox(height: 10,),
//                Divider(height: 1,thickness: 0.1,color: Colors.grey,),
//
//                SizedBox(height: 10,),
//
//                Row(
//                  children: [
//                    Expanded(
//                      child: Text(S.of(context).activeMembers,style: StyleExploreList.getTextSyle(size: 16,fontWeight: FontWeight.w500,
//                        day: false,),),
//                    ),
//                  ],
//                ),
//                SizedBox(height: 10,),
//                Container(
//
//                  height: 100,
//                  child: ListView.builder(itemBuilder: (context,index){
//                    return   Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 4),
//                      child: CardMembers(url_image: 'https://www.lamsahfannan.com/content/uploads/2017/03/3dlat.net_08_15_258a_6.jpg',
//                        series_name: 'name',),
//                    );
//                  },
//                    itemCount:4 ,
//                    shrinkWrap: true,
//                    scrollDirection: Axis.horizontal,),
//                ),
//              ],
//
//            ),
//          ),
//        ),
//
//      ),
//    );
//  }
   }

 }