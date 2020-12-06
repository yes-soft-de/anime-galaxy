import 'dart:ui';

import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_anime/anime_routes.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_episode/episode_routes.dart';
import 'package:anime_galaxy/module_home/model/home_model/home_model.dart';
import 'package:anime_galaxy/module_home/state/home/home.state.dart';
import 'package:anime_galaxy/module_home/state_manager/home/home.state_manager.dart';
import 'package:anime_galaxy/module_home/ui/widget/points_widget/points_widget.dart';
import 'package:anime_galaxy/module_home/ui/widget/series_card/series_card.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class HomeScreen extends StatefulWidget {
  final HomeStateManager _stateManger;
  final AuthService _authService;

  HomeScreen(
    this._stateManger,
    this._authService,
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
          onTap: ()=> Navigator.pushNamed(
              context,
              EpisodeRoutes.ROUTE_EPISODE_DETAILS_SCREEN,
              arguments: item.id
          ),
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                child: Stack(
                  children: <Widget>[
                    Stack(
                      children: [
                        FadeInImage.assetNetwork(
                          placeholder: 'assets/images/logo.jpg',
                          image: item.image,
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.0)),
                          ),
                        )
                      ],
                    ),
                    Positioned.fill(
                      child: Container(
                        color: Colors.black26,
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FadeInImage.assetNetwork(
                                height: 160,
                                width: 75,
                                placeholder: 'assets/images/logo.jpg',
                                image: item.image,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${item.seriesName}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    item.classification??'',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Roboto',
                                        fontSize: 14),
                                  ),
                                  Text(
                                    S.of(context).Episode +
                                        '${item.episodeNumber} ' +
                                        S.of(context).Season +
                                        '${item.season}',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.white70,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                )),
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
          padding: EdgeInsetsDirectional.fromSTEB(7, 0, 7, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PointsWidget(
                points: anime.points,
              ),
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).comingSoonEpisodes,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
//                    Text(
//                      S.of(context).More,
//                      style: TextStyle(
//                        fontSize: 14,
//                        fontFamily: 'Roboto',
//                      ),
//                    ),
                  ],
                ),
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
                        'No New Episodes',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).watchedSeries,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
//                    Text(
//                      S.of(context).More,
//                      style: TextStyle(
//                        fontSize: 14,
//                        fontFamily: 'Roboto',
//                      ),
//                    ),
                  ],
                ),
              ),
              AnimatedSize(
                  vsync: this,
                  duration: const Duration(milliseconds: 500),
                  child: ConstrainedBox(
                    constraints: isExpanded
                        ? BoxConstraints()
                        : BoxConstraints(maxHeight: 180.0),
                    child: GridView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
                              arguments: anime.watchedSeries[index].id),
                          child: SeriesCard(
                            image: anime.watchedSeries[index].image,
                            name: anime.watchedSeries[index].name,
                            classification:
                                anime.watchedSeries[index].classification,
                          ),
                        );
                      },
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: (2.0 / 4)),
                      itemCount: anime.watchedSeries.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                  )),
              isExpanded
                  ? FlatButton(
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: ProjectColors.ThemeColor,
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.white,
                          )),
                      onPressed: () => setState(() => isExpanded = false))
                  : FlatButton(
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: ProjectColors.ThemeColor,
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          )),
                      onPressed: () => setState(() => isExpanded = true)),
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).mayLikeSeries,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold),
                    ),
//                    Text(
//                      S.of(context).More,
//                      style: TextStyle(
//                        fontSize: 14,
//                        fontFamily: 'Roboto',
//                      ),
//                    ),
                  ],
                ),
              ),
              anime.mayLikeSeries.isNotEmpty
                  ? AnimatedSize(
                      vsync: this,
                      duration: Duration(milliseconds: 500),
                      child: ConstrainedBox(
                        constraints: isExpanded2
                            ? BoxConstraints()
                            : BoxConstraints(maxHeight: 180.0),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(context,
                                  AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
                                  arguments: anime.mayLikeSeries[index].id),
                              child: SeriesCard(
                                image: anime.mayLikeSeries[index].image,
                                name: anime.mayLikeSeries[index].name,
                                classification:
                                    anime.mayLikeSeries[index].classification,
                              ),
                            );
                          },
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: (2.0 / 4)),
                          itemCount: anime.mayLikeSeries.length,
                          shrinkWrap: true,
                        ),
                      ))
                  : Text(
                      'Not Enough Data',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                      ),
                    ),
              isExpanded2 && anime.mayLikeSeries.isNotEmpty
                  ? FlatButton(
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: ProjectColors.ThemeColor,
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.white,
                          )),
                      onPressed: () => setState(() => isExpanded2 = false))
                  : FlatButton(
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: ProjectColors.ThemeColor,
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          )),
                      onPressed: () => setState(() => isExpanded2 = true)),
            ],
          ),
        ),
      ),
    );
  }
}
