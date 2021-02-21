import 'dart:ui';

import 'package:anime_galaxy/module_anime/anime_routes.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_episode/episode_routes.dart';
import 'package:anime_galaxy/module_home/model/home_model/home_model.dart';
import 'package:anime_galaxy/module_home/state/home/home.state.dart';
import 'package:anime_galaxy/module_home/state_manager/home/home.state_manager.dart';
import 'package:anime_galaxy/module_home/ui/widget/points_widget/points_widget.dart';
import 'package:anime_galaxy/module_home/ui/widget/series_card/series_card.dart';
import 'package:anime_galaxy/module_theme/service/theme_service/theme_service.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inject/inject.dart';

@provide
class HomeScreen extends StatefulWidget {
  final HomeStateManager _stateManger;
  final AuthService _authService;
  final SwapThemeDataService _themeDataService;

  HomeScreen(
    this._stateManger,
    this._authService,
    this._themeDataService,
  );

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isExpanded = false;
  bool isExpanded2 = false;
  double screenWidth;
  HomeModel anime;
  HomeState currentState = HomeStateInit();
  bool loading = true;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    widget._stateManger.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent() {
    if (currentState is HomeStateFetchingSuccess) {
      HomeStateFetchingSuccess state = currentState;
      anime = state.data;
      loading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    widget._themeDataService.isDarkMode().then((value) {
      isDarkMode = value ?? false;
    });

    screenWidth = MediaQuery.of(context).size.width;
    if (currentState is HomeStateInit) {
      widget._authService.isLoggedIn.then((value) {
        if (value) {
          widget._stateManger.getHomeDetails();
        }
      });
    }

    return loading ? LoadingIndicatorWidget() : getPageLayout();
  }

  Widget getPageLayout() {
    return Scaffold(
      body: body(),
    );
  }

  Future<String> _refresh() async {
    loading = true;
    widget._stateManger.getHomeDetails();
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {});
    return 'success';
  }

  Widget body() {
    //image slider
    List<Widget> imageSliders = [];
    anime.newEpisodes.forEach((item) {
      imageSliders.add(Container(
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
              context, EpisodeRoutes.ROUTE_EPISODE_DETAILS_SCREEN,
              arguments: item.id),
          child: Container(
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/logo.jpg',
              image: item.posterImage,
              fit: BoxFit.cover,
              imageErrorBuilder: (o, err, s) =>
                  Image.asset('assets/images/logo.jpg'),
            ),
          ),
        ),
      ));
    });

    return RefreshIndicator(
      onRefresh: () {
        return _refresh();
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PointsWidget(
                points: anime.points,
              ),
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.grey[400],
                    isDarkMode ? Colors.black26 : Colors.white
                  ],
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'حلقات التي سوف تصدر قريبا',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                /*  );
                },*/
              ),
              imageSliders.isNotEmpty
                  ? CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          autoPlayInterval: Duration(seconds: 4),
                          enlargeCenterPage: false,
                          viewportFraction: 1),
                      items: imageSliders,
                    )
                  : Center(
                      child: Text(
                        'لا يوجد حلقات جديدة',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.grey[400],
                    isDarkMode ? Colors.black26 : Colors.white
                  ],
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المتابعة',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                /*  );
                },*/
              ),

              anime.watchedSeries.isNotEmpty
                  ? Container(
                      height: 180,
//                color:  isDarkMode? Colors.white30 :Colors.grey[400],
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(context,
                                  AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
                                  arguments: anime.watchedSeries[index].id),
                              child: SeriesCard(
                                image: anime.watchedSeries[index].image,
                                name: anime.watchedSeries[index].name,
                              ),
                            ),
                          );
                        },
                        itemCount: anime.watchedSeries.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  : Text(
                      'لم تتابع أي مسلسل بعد',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      ),
                    ),

//              AnimatedSize(
//                  vsync: this,
//                  duration: const Duration(milliseconds: 500),
//                  child: ConstrainedBox(
//                    constraints: isExpanded
//                        ? BoxConstraints()
//                        : BoxConstraints(maxHeight: 180.0),
//                    child: GridView.builder(
//                      itemBuilder: (BuildContext context, int index) {
//                        return GestureDetector(
//                          onTap: () => Navigator.pushNamed(
//                              context, AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
//                              arguments: anime.watchedSeries[index].id),
//                          child: SeriesCard(
//                            image: anime.watchedSeries[index].image,
//                            name: anime.watchedSeries[index].name,
//                            classification:
//                                anime.watchedSeries[index].classification,
//                          ),
//                        );
//                      },
//                      padding: EdgeInsets.symmetric(horizontal: 10),
//                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                          crossAxisCount: 3,
//                          mainAxisSpacing: 20,
//                          crossAxisSpacing: 20,
//                          childAspectRatio: (2.0 / 4)),
//                      itemCount: anime.watchedSeries.length,
//                      physics: NeverScrollableScrollPhysics(),
//                      shrinkWrap: true,
//                    ),
//                  )),
//              isExpanded
//                  ? FlatButton(
//                      child: Container(
//                          width: 30,
//                          height: 30,
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(50),
//                            color: ProjectColors.ThemeColor,
//                          ),
//                          child: const Icon(
//                            Icons.keyboard_arrow_up,
//                            color: Colors.white,
//                          )),
//                      onPressed: () => setState(() => isExpanded = false))
//                  : FlatButton(
//                      child: Container(
//                          width: 30,
//                          height: 30,
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(50),
//                            color: ProjectColors.ThemeColor,
//                          ),
//                          child: const Icon(
//                            Icons.keyboard_arrow_down,
//                            color: Colors.white,
//                          )),
//                      onPressed: () => setState(() => isExpanded = true)),
//
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.grey[400],
                    isDarkMode ? Colors.black26 : Colors.white
                  ],
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'إنميات قد تعجبك',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                /*  );
                },*/
              ),

              anime.mayLikeSeries.isNotEmpty
                  ? Container(
                      height: 190,
//                color:  isDarkMode? Colors.white30 :Colors.grey[400],
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(context,
                                  AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
                                  arguments: anime.mayLikeSeries[index].id),
                              child: SeriesCard(
                                image: anime.mayLikeSeries[index].image,
                                name: anime.mayLikeSeries[index].name,
                              ),
                            ),
                          );
                        },
                        itemCount: anime.mayLikeSeries.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  : Text(
                      'لا يوجد معلومات كافية بعد',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      ),
                    ),

//              anime.mayLikeSeries.isNotEmpty
//                  ? AnimatedSize(
//                      vsync: this,
//                      duration: Duration(milliseconds: 500),
//                      child: ConstrainedBox(
//                        constraints: isExpanded2
//                            ? BoxConstraints()
//                            : BoxConstraints(maxHeight: 180.0),
//                        child: GridView.builder(
//                          physics: NeverScrollableScrollPhysics(),
//                          itemBuilder: (BuildContext context, int index) {
//                            return GestureDetector(
//                              onTap: () => Navigator.pushNamed(context,
//                                  AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
//                                  arguments: anime.mayLikeSeries[index].id),
//                              child: SeriesCard(
//                                image: anime.mayLikeSeries[index].image,
//                                name: anime.mayLikeSeries[index].name,
//                                classification:
//                                    anime.mayLikeSeries[index].classification,
//                              ),
//                            );
//                          },
//                          padding: EdgeInsets.symmetric(horizontal: 10),
//                          gridDelegate:
//                              SliverGridDelegateWithFixedCrossAxisCount(
//                                  crossAxisCount: 3,
//                                  mainAxisSpacing: 20,
//                                  crossAxisSpacing: 20,
//                                  childAspectRatio: (2.0 / 4)),
//                          itemCount: anime.mayLikeSeries.length,
//                          shrinkWrap: true,
//                        ),
//                      ))
//                  : Text(
//                      'Not Enough Data',
//                      style: TextStyle(
//                        fontFamily: 'Roboto',
//                      ),
//                    ),
//              isExpanded2 && anime.mayLikeSeries.isNotEmpty
//                  ? FlatButton(
//                      child: Container(
//                          width: 30,
//                          height: 30,
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(50),
//                            color: ProjectColors.ThemeColor,
//                          ),
//                          child: const Icon(
//                            Icons.keyboard_arrow_up,
//                            color: Colors.white,
//                          )),
//                      onPressed: () => setState(() => isExpanded2 = false))
//                  : FlatButton(
//                      child: Container(
//                          width: 30,
//                          height: 30,
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(50),
//                            color: ProjectColors.ThemeColor,
//                          ),
//                          child: const Icon(
//                            Icons.keyboard_arrow_down,
//                            color: Colors.white,
//                          )),
//                      onPressed: () => setState(() => isExpanded2 = true)),
            ],
          ),
        ),
      ),
    );
  }
}
