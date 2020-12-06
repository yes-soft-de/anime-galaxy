import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';
import 'package:anime_galaxy/module_anime/state/anime_details/anime_details.state.dart';
import 'package:anime_galaxy/module_anime/state_manager/anime_details/anime_details.state_manager.dart';
import 'package:anime_galaxy/module_anime/ui/widget/anime_details_widget/ainme_details_widget.dart';
import 'package:anime_galaxy/module_anime/ui/widget/comment_card/comment_card.dart';
import 'package:anime_galaxy/module_anime/ui/widget/episode_card/episode_card.dart';
import 'package:anime_galaxy/module_anime/ui/widget/spoiler_comment_card/spoiler_comment_card.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_episode/episode_routes.dart';
import 'package:anime_galaxy/module_navigation/ui/widget/navigation_drawer/anime_navigation_drawer.dart';
import 'package:anime_galaxy/module_profile/presistance/profile_shared_preferences.dart';
import 'package:anime_galaxy/module_rating/ui/widget/rating_bar.dart';
import 'package:anime_galaxy/utils/app_bar/anime_galaxy_app_bar.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inject/inject.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../state/anime_details/anime_details.state.dart';

@provide
class AnimeDetailsScreen extends StatefulWidget {
  final AnimeDetailsStateManager _stateManager;
  final AuthService _authService;
  final AnimeNavigationDrawer _animeNavigationDrawer;
  final ProfileSharedPreferencesHelper _profileSharedPreferencesHelper;

  AnimeDetailsScreen(
      this._stateManager,
      this._authService,
      this._animeNavigationDrawer,
      this._profileSharedPreferencesHelper,
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
  bool CommentsVisible = false;

  //youtube video controller
//  YoutubePlayerController _youtubePlayerController;
//  PlayerState _playerState;
//  YoutubeMetaData _videoMetaData;
//  double _volume = 100;
//  bool _muted = false;
//  bool _isPlayerReady = false;

  // ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
      /* anime.trailerVideo??*/
      /**/   'blob:https://www.youtube.com/7665f6c7-323d-4765-ab92-6b9aea6eb06b'
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
    );
    futureController = controller.initialize();
    controller.setLooping(true);  // this will keep video looping active, means video will keep on playing
    controller.setVolume(25.0);
    controller.play();

    _getUserId();

//    _scrollController = ScrollController();
//    _scrollController.addListener(_scrollListener);

    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });

  }

//  void listener() {
//    if (_isPlayerReady && mounted && !_youtubePlayerController.value.isFullScreen) {
//      setState(() {
//        _playerState = _youtubePlayerController.value.playerState;
//        _videoMetaData = _youtubePlayerController.metadata;
//      });
//    }
//  }

  @override
//  void deactivate() {
//     Pauses video while navigating to next page.
//     _youtubePlayerController.pause();
//    super.deactivate();
//  }

  @override
  void dispose() {
  //  _youtubePlayerController.dispose(); // when app is been closed destroyed the controller

    controller.dispose();  // when app is been closed destroyed the controller
    super.dispose();
  }
//  _scrollListener(){
//    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
//        !_scrollController.position.outOfRange) {
//
//      setState(() {
//        fABIsVisible = true ;
//      });
//    }
//    if (_scrollController.offset <= _scrollController.position.minScrollExtent &&
//        !_scrollController.position.outOfRange) {
//
//    /*  setState(() {
//        message = "reach the top";
//      });*/
//    }
//  }
  void _getUserId() async {
    username = await widget._profileSharedPreferencesHelper.getUsername();
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

      //ordinary video initializing
//      controller = VideoPlayerController.network(
//         /* anime.trailerVideo??*/
//           /**/   'blob:https://www.youtube.com/7665f6c7-323d-4765-ab92-6b9aea6eb06b'
//          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
//      );
//      futureController = controller.initialize();
//      controller.setLooping(true);  // this will keep video looping active, means video will keep on playing
//      controller.setVolume(25.0);
//      controller.play();

      //youtube video initializing
//      _youtubePlayerController = YoutubePlayerController(
//        initialVideoId: YoutubePlayer.convertUrlToId(anime.trailerVideo??'https://www.youtube.com/watch?v=BBAyRBTfsOU'),
//        flags: const YoutubePlayerFlags(
//          mute: false,
//          autoPlay: true,
//          disableDragSeek: false,
//          loop: false,
//          isLive: false,
//          forceHD: false,
//          enableCaption: true,
//        ),
//      )..addListener(listener);
//      _videoMetaData = const YoutubeMetaData();
//      _playerState = PlayerState.unknown;

      loading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
    if (currentState is AnimeDetailsStateCommentingSuccess) {
      var df  = new DateFormat('dd/MM');
      if((anime.comments.singleWhere(
              (element) =>
              element.userName == username && element.content == _commentController.text ,
          orElse: () => null)) !=
          null){

      }else{
        anime.comments.insert(
            0,
            new Comment(
                content: _commentController.text,
                userName: username,
                isLoved: false,
                likesNumber: '0',
                //TODO : change this
                userImage:
                'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w',
                date: df.format(DateTime.now()).toString() )
        );
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
      int likes = int.parse(anime.likesNumber);
      likes+=1;
      anime.likesNumber = likes.toString() ;
    }
    if (currentState is AnimeDetailsStateUnFollowSuccess) {
      anime.isFollowed = false;
    }

    if (currentState is AnimeDetailsStateLoveCommentSuccess) {
      AnimeDetailsStateLoveCommentSuccess state = currentState;
      int commentIndex = anime.comments.indexWhere((element) => element.id == state.data);
      print(' comment index'+commentIndex.toString()+'comment id '+state.data.toString());
      anime.comments[commentIndex].isLoved = true;
      int likes = int.parse( anime.comments[commentIndex].likesNumber);
      likes+=1;
      anime.comments[commentIndex].likesNumber = likes.toString();
    }

    if (this.mounted) {
      setState(() {});
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
      appBar: AnimeGalaxyAppBar.getAnimeGalaxyAppBar(context, _scaffoldKey, username,null),
      drawer: widget._animeNavigationDrawer,
      body: Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
//          controller: _scrollController,
          child: body(),
        ),
      ),
      floatingActionButton: Container(
        height: 40,
        width: 40,
        child:CommentsVisible? FloatingActionButton(

          backgroundColor: ProjectColors.ThemeColor,
          onPressed: () {
            _showCommentDialog(context);
          },
          child: Icon(
            Icons.comment,
            color: Colors.white,
          ),
        ):null,
      )
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
            rate: anime.generalRating ?? '0',
            showYear: anime.showYear,
            image: anime.image,
            episodesNumber: anime.episodes.length,
            isFollowed: anime.isFollowed ,
            isLoved: anime.isLoved,
            ageGroup: anime.ageGroup,
            onFollow: () =>
                widget._stateManager.addToFavourite(animeId, anime.categoryID),
            onUnFollow: () =>
                widget._stateManager.unFollowAnime(animeId),
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
              Text(
                  S.of(context).statics,
                  style:TextStyle (
                      fontSize: 14,
                      fontFamily:'Roboto',
                      fontWeight: FontWeight.bold,
                  ),
              ),
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
                style: TextStyle(
                    fontSize: 14,
                    fontFamily:'Roboto',
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
                   style: TextStyle(
                       fontSize: 14,
                       fontFamily:'Roboto'
                   ),
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


          //about
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  S.of(context).About,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily:'Roboto',
                    fontWeight: FontWeight.bold,
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
                      fontSize: 14,
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

          //youtube video player
//         _youtubePlayer(),


          //ordinary video player
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
          ButtonTheme(
            height: 12,
            child: FlatButton(
              color: ProjectColors.ThemeColor,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
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
          ),



         // last episodes
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
                onTap: () {
//                  controller.pause(); // to stop video when navigation to another screen
                  Navigator.pushNamed(
                      context, EpisodeRoutes.ROUTE_EPISODE_DETAILS_SCREEN,
                      arguments: anime.episodes[index].id);
                },
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

          //comments section
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: ButtonTheme(
              height: 12,
              child: FlatButton(
                color: CommentsVisible
                    ? Colors.grey
                    : ProjectColors.ThemeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                onPressed: (){
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
                    fontFamily:'Roboto',
                  ),
                ),
              ),
            ),
          ),
        if(CommentsVisible) _commentsSection(),

          SizedBox(
            height: 60,
          )
        ]),
      ),
    );
  }

  Widget _commentsSection(){
    return Column(
      children: [
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
                        fontSize: 14,
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
            return anime.comments[index].spoilerAlert ?
                         SpoilerCommentCard(
                           userId: anime.comments[index].userId,
                           userImage: '${anime.comments[index].userImage}',
                           userName: '${anime.comments[index].userName}',
                           date:'${ anime.comments[index].date}',
                           likesNumber: anime.comments[index].likesNumber,
                           isLoved:anime.comments[index].isLoved ,
                           onShow:(){
                             anime.comments[index].spoilerAlert = false;
                             setState(() {

                             });
                           },
                         )   :
                        CommentCard(
                          userId: anime.comments[index].userId,
                          userImage: '${anime.comments[index].userImage}',
                          userName: '${anime.comments[index].userName}',
                          date:'${ anime.comments[index].date}',
                          comment: '${anime.comments[index].content}',
                          likesNumber: anime.comments[index].likesNumber,
                          isLoved:anime.comments[index].isLoved ,
                          onLove:()=> widget._stateManager.loveComment(anime.comments[index].id),


                        )  ;
          },
        )
            : Text(
          S.of(context).beTheFirstToComment,
          style: TextStyle(
              fontFamily:'Roboto'
          ),
        ),
      ],
    );
  }
//  Widget _youtubePlayer(){
//    return YoutubePlayerBuilder(
//      onExitFullScreen: () {
//        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
////                SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//      },
//      player: YoutubePlayer(
//        controller: _youtubePlayerController,
//        showVideoProgressIndicator: true,
//        progressIndicatorColor: ProjectColors.ThemeColor,
//        topActions: <Widget>[
//          const SizedBox(width: 8.0),
//          Expanded(
//            child: Text(
//              _youtubePlayerController.metadata.title,
//              style: const TextStyle(
//                color: Colors.white,
//                fontSize: 18.0,
//              ),
//              overflow: TextOverflow.ellipsis,
//              maxLines: 1,
//            ),
//          ),
////
//        ],
//        onReady: () {
//          _isPlayerReady = true;
//        },
////
//      ),
//      builder: (context, player) => Scaffold(
//        key: _scaffoldKey,
//        appBar: AppBar(
//          leading: Padding(
//            padding: const EdgeInsets.only(left: 12.0),
//            child: Image.asset(
//              'assets/ypf.png',
//              fit: BoxFit.fitWidth,
//            ),
//          ),
//
//        ),
//        body: ListView(
//          children: [
//            player,
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                children: [
//
//
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: [
//
//                      IconButton(
//                        icon: Icon(
//                          _youtubePlayerController.value.isPlaying
//                              ? Icons.pause
//                              : Icons.play_arrow,
//                        ),
//                        onPressed: _isPlayerReady
//                            ? () {
//                          _youtubePlayerController.value.isPlaying
//                              ? _youtubePlayerController.pause()
//                              : _youtubePlayerController.play();
//                          setState(() {});
//                        }
//                            : null,
//                      ),
//                      IconButton(
//                        icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
//                        onPressed: _isPlayerReady
//                            ? () {
//                          _muted
//                              ? _youtubePlayerController.unMute()
//                              : _youtubePlayerController.mute();
//                          setState(() {
//                            _muted = !_muted;
//                          });
//                        }
//                            : null,
//                      ),
//                      FullScreenButton(
//                        controller: _youtubePlayerController,
//                        color: Colors.blueAccent,
//                      ),
//
//                    ],
//                  ),
//
//                  Row(
//                    children: <Widget>[
//                      const Text(
//                        "Volume",
//                        style: TextStyle(fontWeight: FontWeight.w300),
//                      ),
//                      Expanded(
//                        child: Slider(
//                          inactiveColor: Colors.transparent,
//                          value: _volume,
//                          min: 0.0,
//                          max: 100.0,
//                          divisions: 10,
//                          label: '${(_volume).round()}',
//                          onChanged: _isPlayerReady
//                              ? (value) {
//                            setState(() {
//                              _volume = value;
//                            });
//                            _youtubePlayerController.setVolume(_volume.round());
//                          }
//                              : null,
//                        ),
//                      ),
//                    ],
//                  ),
//
//
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }

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
