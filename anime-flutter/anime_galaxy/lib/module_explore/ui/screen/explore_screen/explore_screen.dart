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
      imageSliders.add(GestureDetector(
        onTap: ()=> Navigator.pushNamed(
            context,
            AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
           arguments: item.id,
        ),
        child: Container(
          child:  Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage( item.posterImage,),
            fit: BoxFit.fill
        ),
        ),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 8,
                ),
                 Container(
                   margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 7),
                   padding: EdgeInsets.symmetric(horizontal: 10),
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
                        autoPlayInterval: Duration(seconds: 4),
                        enlargeCenterPage: false,
                        viewportFraction: 1),
                    items: imageSliders,
                  ),
                ),

                 Container(
                   margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
                   padding: EdgeInsets.symmetric(horizontal: 10),
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
                  height: 180,
//                  color:  isDarkMode? Colors.white30 :Colors.grey[300],
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
                 margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
                 padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.grey[400],isDarkMode? Colors.black26 :Colors.white],
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الإنميات الموصى بها عربيا حسب تفضيلاتك',
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
                  height: 180,
//                  color:  isDarkMode? Colors.white30 :Colors.grey[300],
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
                   margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
                   padding: EdgeInsets.symmetric(horizontal: 10),
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
                  height: 180,
//                  color:  isDarkMode? Colors.white30 :Colors.grey[300],
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
    );
  }
}
