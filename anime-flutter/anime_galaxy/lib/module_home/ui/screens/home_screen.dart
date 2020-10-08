import 'package:anime_galaxy/module_home/ui/widget/episode_card/episode_card.dart';
import 'package:anime_galaxy/module_home/ui/widget/points_widget/points_widget.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
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

//              CarouselSlider(
//                options: CarouselOptions(
//                  aspectRatio: 2.0,
//                  enlargeCenterPage: true,
//                  scrollDirection: Axis.vertical,
//                  autoPlay: true,
//                ),
//                items: imageSliders,
//              ),

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
                          : new BoxConstraints(maxHeight: 150.0),
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
                        : new BoxConstraints(maxHeight: 150.0),
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


  final List<Widget> imageSliders = imgList.map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'No. ${imgList.indexOf(item)} image',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    ),
  )).toList();
}
