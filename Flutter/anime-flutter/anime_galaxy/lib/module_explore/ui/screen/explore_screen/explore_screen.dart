import 'dart:ui';
import 'package:anime_galaxy/module_anime/anime_routes.dart';
import 'package:anime_galaxy/module_explore/explore_routes.dart';
import 'package:anime_galaxy/module_explore/model/explore/explore_model.dart';
import 'package:anime_galaxy/module_explore/state/explore/explore.state.dart';
import 'package:anime_galaxy/module_explore/state_manager/explore/explore.state_manager.dart';
import 'package:anime_galaxy/module_explore/ui/widget/favourite_series_card/favourite_series_card.dart';
import 'package:anime_galaxy/module_theme/service/theme_service/theme_service.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ExploreScreen extends StatefulWidget {
  final ExploreStateManager _stateManager;
  final SwapThemeDataService _themeDataService;


  ExploreScreen(this._stateManager,this._themeDataService);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ExploreModel explore;
  bool isDarkMode = false;

  ExploreState currentState = ExploreStateInit();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent() {
    if (currentState is ExploreStateFetchingSuccess) {
      ExploreStateFetchingSuccess state = currentState;
      explore = state.data;
      loading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  Future<String> _refresh() async {
    loading = true;
    widget._stateManager.getExploreScreenContent();
    setState(() {});
    return 'success';
  }

  @override
  Widget build(BuildContext context) {

    widget._themeDataService.isDarkMode().then((value) {
      isDarkMode = value ?? false;
    });

    if (currentState is ExploreStateInit) {
      widget._stateManager.getExploreScreenContent();
      if (this.mounted) {
        setState(() {});
      }
    }

    return loading ? LoadingIndicatorWidget() : pageLayout();
  }

  Widget pageLayout() {
//    image slider
    var imageSliders = <Widget>[];
    explore.comingSoonSeries.forEach((item) {
      imageSliders.add(Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              child: Stack(
                children: <Widget>[
                  Stack(
                    fit: StackFit.expand,
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: 'assets/images/logo.jpg',
                        image: item.posterImage,
                      ),
//                        BackdropFilter(
//                          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
//                          child: Container(
//                            decoration: BoxDecoration(
//                                color: Colors.white.withOpacity(0.0)),
//                          ),
//                        )
                    ],
                  ),
//                    Positioned.fill(
//                      child: Container(
//                        color: Colors.black12,
//                      ),
//                    ),
//                    Positioned(
//                      left: 0.0,
//                      right: 0.0,
//                      child: Container(
//                          padding: EdgeInsets.symmetric(
//                              vertical: 10.0, horizontal: 10.0),
//                          child:
//                              Column(
//                                children: <Widget>[
//
//                                      Text(
//                                      '${item.seriesName}',
//                                      overflow: TextOverflow.fade,
//                                      maxLines: 1,
//                                      softWrap: false,
//                                      style: TextStyle(
//                                          color: Colors.white,
//                                          fontSize: 14,
//                                          fontFamily: 'Roboto',
//                                          fontWeight: FontWeight.bold,
//
//                                      ),
//
//                                  ),
////                                  Text(
////                                    item.classification??'',
////                                    style: TextStyle(
////                                        color: Colors.white70,
////                                        fontFamily: 'Roboto',
////                                        fontSize: 13),
////                                  ),
////                                  Text(
////                                    S.of(context).Episode +
////                                        '${item.episodeNumber} ' +
////                                        S.of(context).Season +
////                                        '${item.season}',
////                                    style: TextStyle(
////                                        fontFamily: 'Roboto',
////                                        color: Colors.white70,
////                                        fontSize: 13),
////                                  ),
//                                ],
//                              ),
//
//                           ),
//                    ),
                ],
              )),
                    ),
//                    child: BackdropFilter(
//                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
//                      child: Container(
//                        decoration:
//                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
//                      ),
//                    ),
//                  ),
//                  Positioned(
//                    left: 0.0,
//                    right: 0.0,
//                    child: Container(
//                        padding: EdgeInsets.symmetric(
//                            vertical: 10.0, horizontal: 10.0),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: [
//                            Column(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                Container(
//                                  width: MediaQuery.of(context).size.width*0.6,
//                                  child: Text(
//                                    '${item.name}',
//                                    textAlign: TextAlign.center,
//                                    style: TextStyle(
//                                        color: Colors.white,
//                                        fontSize: 16,
//                                        shadows: [
//                                          Shadow(
//                                            color: ProjectColors.ThemeColor,
//                                            offset: Offset(0.5, 0.5)
//
//                                          ),
//                                        ],
//                                        fontFamily:'Roboto',
//                                        fontWeight: FontWeight.bold
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                            SizedBox(
//                              width: 10,
//                            ),
//                          ],
//                        )),
//                  ),

               ),

       );
    });
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            return _refresh();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                   Container(
                        margin: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 5),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.grey[400], isDarkMode? Colors.black26 :Colors.white],
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الإنميات القادمة',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                  ),


                    

                  Container(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: false,
                      ),
                      items: imageSliders,
                    ),
                  ),

                   Container(
                        margin: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 5),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.grey[400],isDarkMode? Colors.black26 :Colors.white],
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الإنميات الموصى بها عربيا',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                  ),

                  Container(
                    height: 200,
                    color:  isDarkMode? Colors.white30 :Colors.grey[300],
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
                                arguments:
                                    explore.worldRecommendedSeries[index].id),
                            child: FavouriteSeriesCard(
                              url_image:
                                  explore.worldRecommendedSeries[index].image,
                              series_category: explore
                                  .worldRecommendedSeries[index].category,
                              series_name:
                                  explore.worldRecommendedSeries[index].name,
                            ),
                          ),
                        );
                      },
                      itemCount: explore.worldRecommendedSeries.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),


                 Container(
                        margin: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 5),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.grey[400],isDarkMode? Colors.black26 :Colors.white],
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الإنميات الموصى بها حسب تفضيلاتك',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                  ),

                  Container(
                    height: 200,
                    color:  isDarkMode? Colors.white30 :Colors.grey[300],
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
                              arguments:
                                  explore.recommendedSeriesByUser[index].id,
                            ),
                            child: FavouriteSeriesCard(
                              url_image:
                                  explore.recommendedSeriesByUser[index].image,
                              series_category: explore
                                  .recommendedSeriesByUser[index].category,
                              series_name:
                                  explore.recommendedSeriesByUser[index].name,
                            ),
                          ),
                        );
                      },
                      itemCount: explore.recommendedSeriesByUser.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),


                // categories
                   Container(
                        margin: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 5),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.grey[400],isDarkMode? Colors.black26 :Colors.white],
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'تصنيفات الإنمي',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                  ),



                  Container(
                    height: 200,
                    color:  isDarkMode? Colors.white30 :Colors.grey[300],
                    child: explore.categories != null
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, ExploreRoutes.CATEGORY_ANIMES_SCREEN,
                                      arguments: explore.categories[index]),
                                  child: FavouriteSeriesCard(
                                    url_image:  explore.categories[index].image,
                                     series_name:
                                        explore.categories[index].name,
                                    series_category: '',

                                  ),
                                ),
                              );
                            },
                            itemCount: explore.categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                          )
                        : ListView(
                            children: [
                              Text(
                                  'لا يوجد تصنيفات بعد',
                                style: TextStyle(
                                  fontFamily:'Roboto',
                                ),
                              )
                            ],
                          ),
                  ),


                  //active users
//                  Row(
//                    children: [
//                      Expanded(
//                        child: Text(
//                          S.of(context).activeMembers,
//                          style: StyleExploreList.getTextSyle(
//                            size: 14,
//                            fontWeight: FontWeight.w500,
//                            day: true,
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  Container(
//                    height: 100,
//                    child: explore.activeUsers != null
//                        ? ListView.builder(
//                            itemBuilder: (context, index) {
//                              return Padding(
//                                padding:
//                                    const EdgeInsets.symmetric(horizontal: 4),
//                                child: GestureDetector(
//                                  onTap: () => Navigator.pushNamed(
//                                      context, ProfileRoutes.ROUTE_PROFILE,
//                                      arguments: explore.activeUsers[index].id),
//                                  child: MemberCard(
//                                    url_image:  explore.activeUsers[index].image,
//                                     series_name:
//                                        explore.activeUsers[index].name,
//                                  ),
//                                ),
//                              );
//                            },
//                            itemCount: explore.activeUsers.length,
//                            shrinkWrap: true,
//                            scrollDirection: Axis.horizontal,
//                          )
//                        : ListView(
//                            children: [
//                              Text(
//                                  'No Active Users Yet!',
//                                style: TextStyle(
//                                  fontFamily:'Roboto',
//                                ),
//                              )
//                            ],
//                          ),
//                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
