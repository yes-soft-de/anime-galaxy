import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';
import 'package:anime_galaxy/module_anime/state/anime_details/anime_details.state.dart';
import 'package:anime_galaxy/module_anime/state_manager/anime_details/anime_details.state_manager.dart';
import 'package:anime_galaxy/module_anime/ui/widget/anime_details_widget/ainme_details_widget.dart';
import 'package:anime_galaxy/module_anime/ui/widget/comment_card/comment_card.dart';
import 'package:anime_galaxy/module_anime/ui/widget/episode_card/episode_card.dart';
import 'package:anime_galaxy/module_anime/ui/widget/spoiler_comment_card/spoiler_comment_card.dart';
import 'package:anime_galaxy/module_anime/ui/widget/video_player/anime_video_player.dart';
import 'package:anime_galaxy/module_anime/utils/video_url_extractor/video_url_extractor.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_episode/episode_routes.dart';
import 'package:anime_galaxy/module_navigation/ui/widget/navigation_drawer/anime_navigation_drawer.dart';
import 'package:anime_galaxy/module_profile/presistance/profile_shared_preferences.dart';
import 'package:anime_galaxy/module_rating/ui/widget/rating_bar.dart';
import 'package:anime_galaxy/module_theme/service/theme_service/theme_service.dart';
import 'package:anime_galaxy/utils/app_bar/anime_galaxy_app_bar.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inject/inject.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../state/anime_details/anime_details.state.dart';

@provide
class AnimeDetailsScreen extends StatefulWidget {
  final AnimeDetailsStateManager _stateManager;
  final AuthService _authService;
  final AnimeNavigationDrawer _animeNavigationDrawer;
  final ProfileSharedPreferencesHelper _profileSharedPreferencesHelper;
  final SwapThemeDataService _themeDataService;

  AnimeDetailsScreen(
    this._stateManager,
    this._authService,
    this._animeNavigationDrawer,
    this._profileSharedPreferencesHelper,
    this._themeDataService,
  );

  @override
  _AnimeDetailsScreenState createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen>
    with TickerProviderStateMixin<AnimeDetailsScreen> {
  double screenWidth;
  bool isExpanded = false;
  int rating = 0;
  bool loading = true;
  AnimeDetailsState currentState = AnimeDetailsStateInit();
  AnimeModel anime = new AnimeModel();
  bool isSwitched = false;
  int animeId;
  final TextEditingController _commentController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String username;
  String userImage;
  bool CommentsVisible = false;
  bool isDarkMode = false;
  bool canReact = false;

  @override
  void initState() {
    super.initState();
    _getUserId();

    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void _getUserId() async {
    username = await widget._profileSharedPreferencesHelper.getUsername();
    userImage = await widget._profileSharedPreferencesHelper.getImage();
    if (username == null) {
      username = await widget._authService.userID;
      username = username.substring(0, 6);
    }
    if (mounted) setState(() {});
  }

  void processEvent() {
    if (currentState is AnimeDetailsStateFetchingSuccess) {
      AnimeDetailsStateFetchingSuccess state = currentState;
      anime = state.data;
      rating = anime.previousRate;

      loading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
    if (currentState is AnimeDetailsStateCommentingSuccess) {
      var df = new DateFormat('dd/MM');
      if ((anime.comments.singleWhere(
              (element) =>
                  element.userName == username &&
                  element.content == _commentController.text,
              orElse: () => null)) !=
          null) {
      } else {
        if (_commentController.text != '') {
          anime.comments.insert(
              0,
              new Comment(
                  content: _commentController.text,
                  userName: username,
                  isLoved: false,
                  likesNumber: '0',
                  spoilerAlert: false,
                  userImage: userImage ??
                      'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w',
                  date: df.format(DateTime.now()).toString()));
        }

        _commentController.text = '';
      }
    }
    if (currentState is AnimeDetailsStateAddToFavouriteSuccess) {
      anime.isFollowed = true;
    }
    if (currentState is AnimeDetailsStateRatingSuccess) {
      anime.previousRate = rating;
    }
    if (currentState is AnimeDetailsStateLoveSuccess) {
      anime.isLoved = true;
      if (canReact) {
        int likes = int.parse(anime.likesNumber);
        likes += 1;
        anime.likesNumber = likes.toString();
      }
      canReact = false;
    }
    if (currentState is AnimeDetailsStateUnFollowSuccess) {
      anime.isFollowed = false;
    }
    if (currentState is AnimeDetailsStateLoveCommentSuccess) {
      AnimeDetailsStateLoveCommentSuccess state = currentState;
      int commentIndex =
          anime.comments.indexWhere((element) => element.id == state.data);
      anime.comments[commentIndex].isLoved = true;
      if (anime.comments[commentIndex].canReact) {
        int likes = int.parse(anime.comments[commentIndex].likesNumber);
        likes += 1;
        anime.comments[commentIndex].likesNumber = likes.toString();
      }
      anime.comments[commentIndex].canReact = false;
    }

    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    widget._themeDataService.isDarkMode().then((value) {
      isDarkMode = value ?? false;
    });

    animeId = ModalRoute.of(context).settings.arguments;
    screenWidth = MediaQuery.of(context).size.width;

    if (currentState is AnimeDetailsStateInit) {
      widget._stateManager.getAnimeDetails(animeId);
      if (this.mounted) {
        setState(() {});
      }
    }
    return Scaffold(
      body: loading ? LoadingIndicatorWidget() : getPageLayout(),
    );
  }

  Widget setErrorUI() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Text(S.of(context).errorLoadingItems),
        OutlineButton(
          onPressed: () {
            loading = true;
            widget._stateManager.getAnimeDetails(animeId);
          },
          child: Text(S.of(context).retry),
        )
      ],
    );
  }

  Widget getPageLayout() {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AnimeGalaxyAppBar.getAnimeGalaxyAppBar2(
            context, _scaffoldKey, username, userImage),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              child: Column(children: [
                AnimeDetailsWidget(
                  name: anime.name,
                  comments: anime.commentsNumber,
                  likes: anime.likesNumber,
                  showYear: anime.showYear,
                  image: anime.image,
                  episodesNumber: anime.episodes.length,
                  isFollowed: anime.isFollowed,
                  isLoved: anime.isLoved,
                  ageGroup: anime.ageGroup,
                  onFollow: () => widget._stateManager
                      .addToFavourite(animeId, anime.categories),
                  onUnFollow: () => widget._stateManager.unFollowAnime(animeId),
                  onLove: () {
                    widget._stateManager.loveAnime(animeId);
                    canReact = true;
                  },
                ),
                //rating the series
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).RateSeries,
                        style: TextStyle(fontSize: 14),
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: AnimeRatingBar(
                          rating: rating ?? 10,
                          fillIcon: ImageIcon(
                            AssetImage('assets/images/full_flame.png'),
                            color: ProjectColors.ThemeColor,
                          ),
                          halfFillIcon: ImageIcon(
                            AssetImage('assets/images/full_flame.png'),
                            color: ProjectColors.ThemeColor,
                          ),
                          emptyIcon: ImageIcon(
                            AssetImage('assets/images/flame.png'),
                            color: ProjectColors.ThemeColor,
                          ),
                          onRatingChanged: (rating) {
                            if (anime.previousRate == 0) {
                              widget._stateManager.rateAnime(animeId, rating);
                              this.rating = rating;
                              setState(() {});
                            } else {
                              Fluttertoast.showToast(
                                  msg: S.of(context).YouHaveRatedThisAnime);
                            }
                          },
                          itemSize: 25,
                          itemCount: 10,
                        ),
                      ),
                    ],
                  ),
                ),

                //Statistics
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
                        S.of(context).statics,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  /*   );
                  },*/
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).generalEvaluation,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            anime.rate != null
                                ? ((double.parse(anime.rate) * 10).floor() / 10)
                                    .toString()
                                : 0.toString(),
                            style:
                                TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                          ),
                          Icon(Icons.star_border,
                              color: ProjectColors.ThemeColor),
                        ],
                      )
//              LinearPercentIndicator(
//                width: MediaQuery.of(context).size.width * 0.5,
//                animation: true,
//                lineHeight: 12.0,
//                animationDuration: 1500,
//                percent: 0.8,
//                linearStrokeCap: LinearStrokeCap.roundAll,
//                progressColor: Color(0xfff77f00),
//              ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MAL',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            anime.generalRating != null
                                ? ((double.parse(anime.generalRating) * 10)
                                            .floor() /
                                        10)
                                    .toString()
                                : 0.toString(),
                            style:
                                TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                          ),
                          Icon(Icons.star_border,
                              color: ProjectColors.ThemeColor),
                        ],
                      )
//              LinearPercentIndicator(
//                width: MediaQuery.of(context).size.width * 0.5,
//                animation: true,
//                lineHeight: 12.0,
//                animationDuration: 1500,
//                percent: 0.8,
//                linearStrokeCap: LinearStrokeCap.roundAll,
//                progressColor: Color(0xfff77f00),
//              ),
                    ],
                  ),
                ),

                //about
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
                        S.of(context).About,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  /*    );
                  },*/
                ),

                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black38),
                  ),
                  child: Text(
                    '${anime.about}',
                    style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                  ),
                ),

                //divider
                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  height: 1,
                  width: screenWidth * 0.8,
                  color: Colors.black38,
                ),

                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
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
                        S.of(context).Classification,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  /*    );
                  },*/
                ),

                //classifications

                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black38)),
                        child: Center(
                            child: Text(
                          '${anime.categories[index].name}',
                          style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                        )));
                  },
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: (3 / 1)),
                  itemCount:
                      anime.categories != null ? anime.categories.length : 0,
                  shrinkWrap: true,
                ),
                //divider
                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  height: 1,
                  width: screenWidth * 0.8,
                  color: Colors.black38,
                ),

                //Trailer video
                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
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
                        'التريلر',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                FutureBuilder(
                  future: VideoUrlExtractor.getVideoUrlFromYoutube(
                      anime.trailerVideo),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.hasData) {
                      return AnimeVideoPlayer(snapshot.data[0]);
                    } else {
                      return Container();
                    }
                  },
                ),

                // last episodes
                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
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
                        S.of(context).LastEpisodes,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  /*   );
                  },*/
                ),

                // last episodes
                anime.episodes.isNotEmpty
                    ? Container(
                        height: 210,
//                  color:  isDarkMode? Colors.white30 :Colors.grey[300],
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        EpisodeRoutes
                                            .ROUTE_EPISODE_DETAILS_SCREEN,
                                        arguments: anime.episodes[index].id);
                                  },
                                  child: EpisodeCard(
                                    image: anime.episodes[index].image,
                                    episodeNumber:
                                        anime.episodes[index].episodeNumber,
                                    classification:
                                        anime.episodes[index].classification,
                                  ),
                                ));
                          },
                          itemCount: anime.episodes.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    : Text(
                        S.of(context).noNewEpisodes,
                        style: TextStyle(fontFamily: 'Roboto'),
                      ),

                //comments section
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ButtonTheme(
                    height: 12,
                    child: FlatButton(
                      color: CommentsVisible
                          ? Colors.grey
                          : ProjectColors.ThemeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      onPressed: () {
                        setState(() {
                          CommentsVisible = !CommentsVisible;
                        });
                      },
                      child: Text(
                        CommentsVisible
                            ? S.of(context).hideComments
                            : S.of(context).showComments,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),
                ),
                if (CommentsVisible) _commentsSection(),

                SizedBox(
                  height: 60,
                )
              ]),
            ),
          ),
        ),
        floatingActionButton: Container(
          height: 40,
          width: 40,
          child: CommentsVisible
              ? FloatingActionButton(
                  backgroundColor: ProjectColors.ThemeColor,
                  onPressed: () {
                    _showCommentDialog(context);
                  },
                  child: Icon(
                    Icons.comment,
                    color: Colors.white,
                  ),
                )
              : null,
        ));
  }

  Widget _commentsSection() {
    return Column(
      children: [
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
                S.of(context).LastReplaysAndComments,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          /*   );
          },*/
        ),
        anime.comments.isNotEmpty
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: anime.comments != null ? anime.comments.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      anime.comments[index].spoilerAlert
                          ? SpoilerCommentCard(
                              userId: anime.comments[index].userId,
                              userImage: '${anime.comments[index].userImage}',
                              userName: '${anime.comments[index].userName}',
                              date: '${anime.comments[index].date}',
                              likesNumber: anime.comments[index].likesNumber,
                              isLoved: anime.comments[index].isLoved,
                              onShow: () {
                                anime.comments[index].spoilerAlert = false;
                                setState(() {});
                              },
                            )
                          : CommentCard(
                              userId: anime.comments[index].userId,
                              userImage: '${anime.comments[index].userImage}',
                              userName: '${anime.comments[index].userName}',
                              date: '${anime.comments[index].date}',
                              comment: '${anime.comments[index].content}',
                              likesNumber: anime.comments[index].likesNumber,
                              isLoved: anime.comments[index].isLoved,
                              onLove: () {
                                widget._stateManager
                                    .loveComment(anime.comments[index].id);
                                anime.comments[index].canReact = true;
                              },
                            ),
                      Divider(),
                    ],
                  );
                },
              )
            : Text(
                S.of(context).beTheFirstToComment,
                style: TextStyle(fontFamily: 'Roboto'),
              ),
      ],
    );
  }

  void _showCommentDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // here we use a nested StatefulWidget builder so that the dialog can
          // micromanage it's own state
          return StatefulBuilder(builder: (context, setState) {
            return SimpleDialog(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        margin: EdgeInsetsDirectional.fromSTEB(10, 0, 5, 5),
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
                              S.of(context).newInteraction,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        /*     );
                        },*/
                      ),

//
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextField(
                          controller: _commentController,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 14,
                          ),
                          maxLines: 8,
                          decoration: InputDecoration.collapsed(
                            hintText: S.of(context).addYourComment,
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).spoilerAlert,
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 10,
                                      color: Colors.white),
                                )),
                            Container(
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey),
                              child: Switch(
                                value: isSwitched,
                                onChanged: (isOn) {
                                  setState(() {
                                    isSwitched = !isSwitched;
                                  });
                                },
                                activeTrackColor: ProjectColors.ThemeColor,
                                activeColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FlatButton(
                          onPressed: () {
                            widget._stateManager.addComment(
                                _commentController.text.trim(),
                                animeId,
                                isSwitched);
                            Navigator.pop(context, true);
                          },
                          child: Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ProjectColors.ThemeColor,
                            ),
                            child: Text(S.of(context).sendComment,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 10,
                                      color: Colors.white),
                                )),
                          )),
                    ],
                  ),
                )
              ],
            );
          });
        });
  }
}
