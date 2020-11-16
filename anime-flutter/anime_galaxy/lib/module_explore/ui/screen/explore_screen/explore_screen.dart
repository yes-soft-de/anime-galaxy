import 'dart:ui';

import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_anime/anime_routes.dart';
import 'package:anime_galaxy/module_explore/model/explore/explore_model.dart';
import 'package:anime_galaxy/module_explore/state/explore/explore.state.dart';
import 'package:anime_galaxy/module_explore/state_manager/explore/explore.state_manager.dart';
import 'package:anime_galaxy/module_explore/style/style_explore_list.dart';
import 'package:anime_galaxy/module_explore/ui/widget/favourite_series_card/favourite_series_card.dart';
import 'package:anime_galaxy/module_explore/ui/widget/member_card/member_card.dart';
import 'package:anime_galaxy/module_explore/ui/widget/series_card/card_series.dart';
import 'package:anime_galaxy/module_profile/profile_routes.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ExploreScreen extends StatefulWidget {
  final ExploreStateManager _stateManager;

  ExploreScreen(this._stateManager);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ExploreModel explore;

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
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${item.name}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )),
                  ),
                ],
              )),
        ),
      ));
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          S.of(context).worldWideSeries,
                          style: StyleExploreList.getTextSyle(
                            size: 14,
                            fontWeight: FontWeight.w500,
                            day: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
                                arguments:
                                    explore.worldRecommendedSeries[index].id),
                            child: SeriesCard(
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
                  Divider(
                    height: 1,
                    thickness: 0.1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          S.of(context).recomendationByFavorite,
                          style: StyleExploreList.getTextSyle(
                            size: 14,
                            fontWeight: FontWeight.w500,
                            day: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
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
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          S.of(context).activeMembers,
                          style: StyleExploreList.getTextSyle(
                            size: 14,
                            fontWeight: FontWeight.w500,
                            day: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: explore.activeUsers != null
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, ProfileRoutes.ROUTE_PROFILE,
                                      arguments: explore.activeUsers[index].id),
                                  child: MemberCard(
                                    //TODO : edit this when response added to backend
                                    url_image:
                                        'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=60 200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=60 300w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60 400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60 500w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60 600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60 700w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60 800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60 900w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60 1000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=60 1100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1200&q=60 1200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60 1296w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60 1400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=60 1600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1800&q=60 1800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2000&q=60 2000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2200&q=60 2200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2400&q=60 2400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2592&q=60 2592w',
                                    series_name:
                                        explore.activeUsers[index].name,
                                  ),
                                ),
                              );
                            },
                            itemCount: explore.activeUsers.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                          )
                        : ListView(
                            children: [Text('No Active Users Yet!')],
                          ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                      items: imageSliders,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
