import 'dart:ui';
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_home/model/home_model/home_model.dart';
import 'package:anime_galaxy/module_home/state/home/home.state.dart';
import 'package:anime_galaxy/module_home/ui/widget/episode_card/episode_card.dart';
import 'package:anime_galaxy/module_home/ui/widget/points_widget/points_widget.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/module_home/state_manager/home/home.state_manager.dart';
import 'package:shimmer/shimmer.dart';


@provide
class HomeScreen extends StatefulWidget {
  final HomeStateManager  _stateManger;

  HomeScreen(
      this._stateManger,
  );

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isExpanded = false;
  bool isExpanded2 = false;
  double screenWidth;
  HomeModel anime;
  HomeState currentState =  HomeStateInit();
  bool  loading =true;

  @override
  void initState() {
    super.initState();
    widget._stateManger.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }
  void processEvent(){
    if(currentState is HomeStateFetchingSuccess){
      HomeStateFetchingSuccess state = currentState;
      anime = state.data;
      loading = false;
      if(this.mounted){
        setState(() {

        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    if (currentState is HomeStateInit) {
      widget._stateManger.getHomeDetails();
      if(this.mounted){
        setState(() {});
      }
    }



    return getPageLayout();

  }

  Widget getPageLayout(){

    return Scaffold(
      appBar: AppBar(title: Text('Anime'),),
      body:loading ?
              Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled:  true,

              child: body()
          ):
            body()
    );
  }



  Widget body(){

      final List<Widget> imageSliders = anime.newEpisodes
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
                        image: new  NetworkImage(item.image , ),
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
                                  item.seriesName,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),

                                Text(
                                  item.classification,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 8
                                  ),
                                ),
                                Text(
                                  S.of(context).Episode +'${item.episodeNumber} ' + S.of(context).Season + '${item.season}',
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

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(7, 0, 7, 10),
        child: Column(
          children: [
            PointsWidget(
              points: anime.points,
            ),
            Container(
              margin: EdgeInsetsDirectional.fromSTEB(10,0,10,20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).More,
                    style: TextStyle(
                        fontSize: 10
                    ),
                  ),
                  Text(
                    S.of(context).newEpisodes,
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
                   S.of(context).More,
                    style: TextStyle(
                        fontSize: 10
                    ),
                  ),
                  Text(
                    S.of(context).watchedSeries,
                    style: TextStyle(
                        fontSize: 10
                    ),
                  ),
                ],
              ),
            ),
            new AnimatedSize(
                vsync: this,
                duration: const Duration(milliseconds: 500),
                child: new ConstrainedBox(
                  constraints: isExpanded
                      ? new BoxConstraints()
                      : new BoxConstraints(maxHeight: 175.0),
                  child:    GridView.builder(itemBuilder: (BuildContext context, int index){

                    return  EpisodeCard(
                      image: anime.watchedSeries[index].image,
                      episodeNumber: 1,
                      classification:anime.watchedSeries[index].classification,
                    );
                  },
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: (2.3/4)
                    ),
                    itemCount:anime.watchedSeries.length,
                     physics: NeverScrollableScrollPhysics(),
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
                   S.of(context).More,
                    style: TextStyle(
                        fontSize: 10
                    ),
                  ),
                  Text(
                    S.of(context).mayLikeSeries,
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
                  child:    GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index){

                    return  EpisodeCard(
                      image: anime.mayLikeSeries[index].image,
                      episodeNumber: 1,
                      classification: anime.mayLikeSeries[index].classification,
                    );
                  },
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: (2.3/4)
                    ),
                    itemCount:anime.mayLikeSeries.length,

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
    );
  }




}
