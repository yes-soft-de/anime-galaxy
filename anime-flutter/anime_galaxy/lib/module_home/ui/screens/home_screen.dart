import 'dart:ui';

import 'package:anime_galaxy/module_home/ui/widget/episode_card/episode_card.dart';
import 'package:anime_galaxy/module_home/ui/widget/points_widget/points_widget.dart';
import 'package:anime_galaxy/module_upload/response/imgbb/imgbb_response.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

final List<String> imgList = [
  'https://i.pinimg.com/236x/ab/46/ae/ab46ae9f35056e9a34072295fd974e9c.jpg',
 'https://i.pinimg.com/236x/2a/85/a9/2a85a97e119b597cab78dff22ac9f7a2--city-landscape-landscape-wallpaper.jpg',
  'https://i.pinimg.com/236x/10/43/25/10432589c5c2a8f9521c9c33e8ab337b--art-background-animation-background.jpg',
'https://i.pinimg.com/236x/e9/55/3d/e9553dfe572e71ba82811a3dad2def52.jpg'
];

@provide
class HomeScreen extends StatefulWidget {

  HomeScreen(
  );

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<int> episodes = [1,2,3,4,5,6];
  List<int> episodes2 = [1,2,3,4,5,6,7,8  ];
  bool isExpanded = false;
  bool isExpanded2 = false;
  double screenWidth;


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return getPageLyout();
  }

  Widget getPageLyout(){

    return Scaffold(
      appBar: AppBar(title: Text('Anime'),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(7, 0, 7, 10),
          child: Column(
            children: [
              PointsWidget(
                points: 76,
              ),
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(10,0,10,20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المزيد',
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                    Text(
                      'حلقات جديدة',
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                  ],
                ),
              ),


              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: false,
                  viewportFraction:1
                ),
                items: imageSliders,

              ),

              Container(
                margin: EdgeInsetsDirectional.fromSTEB(10,0,10,20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المزيد',
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                    Text(
                      'مسلسلات متابعة',
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                  ],
                ),
              ),     new AnimatedSize(
                  vsync: this,
                  duration: const Duration(milliseconds: 500),
                  child: new ConstrainedBox(
                      constraints: isExpanded
                          ? new BoxConstraints()
                          : new BoxConstraints(maxHeight: 175.0),
                      child:    GridView.builder(itemBuilder: (BuildContext context, int index){

                          return  EpisodeCard(
                            image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
                            episodeNumber: episodes[index],
                            classification: 'أكشن شاونين',
                          );
                        },
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: (2.3/4)
                          ),
                          itemCount:episodes.length,

                          shrinkWrap: true,),

//
                  )
              ),
              isExpanded
                  ?  new FlatButton(
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: ProjectColors.ThemeColor,
                      ),

                      child: const Icon(Icons.keyboard_arrow_up,color: Colors.white,)),
                  onPressed: () => setState(() => isExpanded = false))

                  : new FlatButton(
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: ProjectColors.ThemeColor,
                      ),

                      child: const Icon(Icons.keyboard_arrow_down,color: Colors.white,)),
                  onPressed: () => setState(() => isExpanded = true))
              ,
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(10,0,10,20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المزيد',
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                    Text(
                      'مسلسلات قد تعجبك',
                      style: TextStyle(
                          fontSize: 10
                      ),
                    ),
                  ],
                ),
              ),     new AnimatedSize(
                  vsync: this,
                  duration: const Duration(milliseconds: 500),
                  child: new ConstrainedBox(
                    constraints: isExpanded2
                        ? new BoxConstraints()
                        : new BoxConstraints(maxHeight: 175.0),
                    child:    GridView.builder(itemBuilder: (BuildContext context, int index){

                      return  EpisodeCard(
                        image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
                        episodeNumber: episodes2[index],
                        classification: 'أكشن شاونين',
                      );
                    },
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 6,
                          childAspectRatio: (1.8/4)
                      ),
                      itemCount:episodes2.length,

                      shrinkWrap: true,),

//
                  )
              ),
              isExpanded2
                  ?  new FlatButton(
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: ProjectColors.ThemeColor,
                      ),

                      child: const Icon(Icons.keyboard_arrow_up,color: Colors.white,)),
                  onPressed: () => setState(() => isExpanded2 = false))

                  : new FlatButton(
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: ProjectColors.ThemeColor,
                      ),

                      child: const Icon(Icons.keyboard_arrow_down,color: Colors.white,)),
                  onPressed: () => setState(() => isExpanded2 = true))
              ,
            ],
          ),
        ),
      ),
    );
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          child: Stack(
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new  NetworkImage(item , ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                  child: new Container(
                    decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),


              Positioned(
                left: 0.0,
                right: 0.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Text(
                            'Hunter X Hunter',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),

                          Text(
                            'أكشن-مغامرة-شاونين',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 8
                            ),
                          ),
                          Text(
                            'الحلقة 24 الموسم 3',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: 75,
                        height: 160,
                        child: Image(

                          image: NetworkImage(
                              'https://m.media-amazon.com/images/M/MV5BZjNmZDhkN2QtNDYyZC00YzJmLTg0ODUtN2FjNjhhMzE3ZmUxXkEyXkFqcGdeQXVyNjc2NjA5MTU@._V1_UX182_CR0,0,182,268_AL_.jpg'
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
            ],
          )),
    ),
  ))
      .toList();

}
