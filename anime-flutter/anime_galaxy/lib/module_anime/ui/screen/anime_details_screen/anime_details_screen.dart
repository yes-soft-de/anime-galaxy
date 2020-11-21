import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';
import 'package:anime_galaxy/module_anime/state/anime_details/anime_details.state.dart';
import 'package:anime_galaxy/module_anime/state_manager/anime_details/anime_details.state_manager.dart';
import 'package:anime_galaxy/module_anime/ui/widget/anime_details_widget/ainme_details_widget.dart';
import 'package:anime_galaxy/module_anime/ui/widget/comment_card/comment_card.dart';
import 'package:anime_galaxy/module_anime/ui/widget/episode_card/episode_card.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_episode/episode_routes.dart';
import 'package:anime_galaxy/module_navigation/ui/widget/navigation_drawer/anime_navigation_drawer.dart';
import 'package:anime_galaxy/module_rating/ui/widget/rating_bar.dart';
import 'package:anime_galaxy/utils/app_bar/anime_galaxy_app_bar.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inject/inject.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';

@provide
class AnimeDetailsScreen extends StatefulWidget {
  final AnimeDetailsStateManager _stateManager;
  final AuthService _authService;

  AnimeDetailsScreen(
    this._stateManager,
    this._authService,
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
  VideoPlayerController controller; // used to controller videos
  Future<void> futureController;

  @override
  void initState() {
    super.initState();
    _getUserId();


    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void dispose() {
    controller.dispose();  // when app is been closed destroyed the controller
    super.dispose();
  }

  void _getUserId() async {
    username = await widget._authService.username;
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

      controller = VideoPlayerController.network(anime.trailerVideo??'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4');
      futureController = controller.initialize();
      controller.setLooping(true);  // this will keep video looping active, means video will keep on playing
      controller.setVolume(25.0);
      controller.play();

      loading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
    if (currentState is AnimeDetailsStateCommentingSuccess) {
      anime.comments.insert(
          0,
          new Comment(
              content: _commentController.text,
              userName: username,
              //TODO : change this
              userImage:
                  'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=60 200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=60 300w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60 400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60 500w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60 600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60 700w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60 800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60 900w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60 1000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=60 1100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1200&q=60 1200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60 1296w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60 1400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=60 1600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1800&q=60 1800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2000&q=60 2000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2200&q=60 2200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2400&q=60 2400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2592&q=60 2592w',
              date: '21 Jun'));
      _commentController.text = '';

      if (this.mounted) {
        setState(() {});
      }
    }
    if (currentState is AnimeDetailsStateAddToFavouriteSuccess) {
      anime.isFollowed = true;

      if (this.mounted) {
        setState(() {});
      }
    }
    if (currentState is AnimeDetailsStateRatingSuccess) {
      anime.previousRate = rating;
      if (this.mounted) {
        setState(() {});
      }
    }
    if (currentState is AnimeDetailsStateLoveSuccess) {

      int likes = int.parse(anime.likesNumber);
      likes+=1;
      anime.likesNumber = likes.toString() ;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    animeId = ModalRoute.of(context).settings.arguments;
    screenWidth = MediaQuery.of(context).size.width;

    if (currentState is AnimeDetailsStateInit) {
      widget._stateManager.getAnimeDetails(animeId);
      if (this.mounted) {
        setState(() {});
      }
    }
    return loading ? LoadingIndicatorWidget() : getPageLayout();
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
      appBar: AnimeGalaxyAppBar.getAnimeGalaxyAppBar(_scaffoldKey, username),
      drawer: AnimeNavigationDrawer(),
      body: Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: body(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ProjectColors.ThemeColor,
        onPressed: () {
          _showCommentDialog(context);
        },
        child: Icon(
          Icons.comment,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget body() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          AnimeDetailsWidget(
            name: anime.name,
            comments: anime.commentsNumber,
            likes: anime.likesNumber,
            rate: anime.rate ?? '0',
            showYear: anime.showYear,
            image: anime.image,
            episodesNumber: anime.episodes.length,
            isFollowed: anime.isFollowed,
            onFollow: () =>
                widget._stateManager.addToFavourite(animeId, anime.categoryID),
            onLove: ()=>
                widget._stateManager.loveAnime(animeId),
          ),
          //rating the series
          Row(
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
                    if(anime.previousRate == 0 ){
                      widget._stateManager.rateAnime(animeId, rating);
                      this.rating = rating;
                      setState(() {

                      });
                    }else{
                      Fluttertoast.showToast(msg: S.of(context).YouHaveRatedThisAnime);
                    }

                  }
                   ,
                  itemSize: 25,
                  itemCount: 10,
                ),
              ),
            ],
          ),

          //Statistics
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(S.of(context).statics),
              SizedBox(
                width: 10,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).generalEvaluation,
                style: TextStyle(fontSize: 14),
              ),
              //TODO : change it with real data
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * 0.5,
                animation: true,
                lineHeight: 12.0,
                animationDuration: 1500,
                percent: 0.8,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Color(0xfff77f00),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).monthlyComments,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily:'Roboto'
                ),

              ),
              //TODO : change it with real data
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * 0.5,
                animation: true,
                lineHeight: 12.0,
                animationDuration: 1500,
                percent: 0.8,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Color(0xfff77f00),
              ),
            ],
          ),

          //about
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  S.of(context).About,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily:'Roboto'
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),

          AnimatedSize(
              vsync: this,
              duration: const Duration(milliseconds: 500),
              child: new ConstrainedBox(
                  constraints: isExpanded
                      ? new BoxConstraints()
                      : new BoxConstraints(maxHeight: 75.0),
                  child: Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black38),
                    ),
                    child: Text(
                      '${anime.about}',
                      style: TextStyle(
                        fontSize: 12,
                          fontFamily:'Roboto'
                      ),
                    ),
                  ))),
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

          //divider
          Container(
            margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
            height: 1,
            width: screenWidth * 0.8,
            color: Colors.black38,
          ),
          Container(
            margin: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).Classification,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                      fontFamily:'Roboto'
                  ),
                ),
              ],
            ),
          ),

          //classifications
          Wrap(
            children: [
              Container(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                  margin: EdgeInsets.only(left: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black38)),
                  child: Center(
                      child: Text(
                    '${anime.classification}',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily:'Roboto'
                    ),
                  ))),
            ],
          ),

          //divider
          Container(
            margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
            height: 1,
            width: screenWidth * 0.8,
            color: Colors.black38,
          ),

          //Trailer video
          FutureBuilder(
            future: futureController,
            builder: (context,snapshot){
              // if video to ready to play, else show a progress bar to the user
              if(snapshot.connectionState == ConnectionState.done)
              {
                return AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller)
                );
              }else{
                return Center(child: CircularProgressIndicator(),);
              }

            },
          ),

          //button to play/pause the video
          RaisedButton(
            color: Colors.transparent,
            child: Icon(
                controller.value.isPlaying? Icons.pause : Icons.play_arrow
            ),
            onPressed: (){
              setState(() {
                if(controller.value.isPlaying)
                {
                  controller.pause();
                }
                else
                {
                  controller.play();
                }
              });
            },
          ),


          //last episodes
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).LastEpisodes,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                          fontFamily:'Roboto'
                      ),
                    ),
                  ],
                )),
          ),
          // last episodes
          anime.episodes.isNotEmpty
              ? GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, EpisodeRoutes.ROUTE_EPISODE_DETAILS_SCREEN,
                          arguments: anime.episodes[index].id),
                      child: EpisodeCard(
                        image: anime.episodes[index].image,
                        episodeNumber: anime.episodes[index].episodeNumber,
                        classification: anime.episodes[index].classification,
                      ),
                    );
                  },
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: (2.3 / 4)),
                  itemCount: anime.episodes != null ? anime.episodes.length : 0,
                  shrinkWrap: true,
                )
              : Text(
              S.of(context).noNewEpisodes,
                style: TextStyle(
                    fontFamily:'Roboto'
                ),
          ),

          Container(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).LastReplaysAndComments,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                          fontFamily:'Roboto'
                      ),
                    ),
                  ),
                ],
              )),
          anime.comments.isNotEmpty
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: anime.comments != null ? anime.comments.length : 0,
                  itemBuilder: (BuildContext context, int index) {
                    return CommentCard(
                      userImage: '${anime.comments[index].userImage}',
                      userName: '${anime.comments[index].userName}',
                      date:'${ anime.comments[index].date}',
                      comment: '${anime.comments[index].content}',
                    );
                  },
                )
              : Text(
              S.of(context).beTheFirstToComment,
                style: TextStyle(
                    fontFamily:'Roboto'
                ),
          ),

          SizedBox(
            height: 60,
          )
        ]),
      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(S.of(context).newInteraction,
                              style: TextStyle(
                                  fontFamily:'Roboto'
                              )
                          ),
                        ],
                      ),
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
                              fontFamily:'Roboto',
                              fontSize: 14,
                          ),
                          maxLines: 8,
                          decoration: InputDecoration.collapsed(
                            hintText: S.of(context).addYourComment,
                            hintStyle: TextStyle(
                                color: Colors.white,
                              fontFamily:'Roboto',
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
                            Switch(
                              value: isSwitched,
                              onChanged: (isOn) {
                                setState(() {
                                  isSwitched = !isSwitched;
                                });
                              },
                              activeTrackColor: ProjectColors.ThemeColor,
                              activeColor: Colors.white,
                            ),
                            Text(S.of(context).spoilerAlert,
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontFamily:'Roboto',
                                      fontSize: 10,
                                      color: Colors.white
                                  ),
                                ))
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
                                      fontFamily:'Roboto',
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
