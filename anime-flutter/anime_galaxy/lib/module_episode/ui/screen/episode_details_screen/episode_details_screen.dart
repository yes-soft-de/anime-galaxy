import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_episode/model/episode_model/episode_model.dart';
import 'package:anime_galaxy/module_episode/state/episode_details/episode_details.state.dart';
import 'package:anime_galaxy/module_episode/state_manager/episode_details/episode_details.state_manager.dart';
import 'package:anime_galaxy/module_episode/ui/widget/comment_card/comment_card.dart';
import 'package:anime_galaxy/module_episode/ui/widget/episode_details_widget/episode_details_widget.dart';
import 'package:anime_galaxy/module_navigation/ui/widget/navigation_drawer/anime_navigation_drawer.dart';
import 'package:anime_galaxy/module_rating/ui/widget/rating_bar.dart';
import 'package:anime_galaxy/utils/app_bar/anime_galaxy_app_bar.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inject/inject.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

@provide
class EpisodeDetailsScreen extends StatefulWidget {
  final EpisodeDetailsStateManager _stateManager;
  final AuthService _authService;
  final AnimeNavigationDrawer _animeNavigationDrawer;

  EpisodeDetailsScreen(
      this._stateManager,
      this._authService,
      this._animeNavigationDrawer,
      );
  @override
  _EpisodeDetailsScreenState createState() => _EpisodeDetailsScreenState();
}

class _EpisodeDetailsScreenState extends State<EpisodeDetailsScreen>
    with TickerProviderStateMixin<EpisodeDetailsScreen> {
  double screenWidth;
  bool isExpanded = false;
  int rating = 0;
  bool loading = true;
  EpisodeDetailsState currentState = EpisodeDetailsStateInit();
  EpisodeModel episode = new EpisodeModel();
  bool isSwitched = false;
  int episodeId;
  final TextEditingController _commentController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String username;

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
    username = await widget._authService.username;
    if (username == null) {
      username = await widget._authService.userID;
      username = username.substring(0, 6);
    }
  }

  void processEvent() {
    if (currentState is EpisodeDetailsStateFetchingSuccess) {
      EpisodeDetailsStateFetchingSuccess state = currentState;
      episode = state.data;
      rating = episode.previousRate;
      loading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
    if (currentState is EpisodeDetailsStateCommentingSuccess) {
      episode.comments.insert(
          0,
          new Comment(
              content: _commentController.text,
              userName: username,
              //TODO : change the below
              userImage:
                  'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=60 200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=60 300w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60 400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60 500w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60 600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60 700w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60 800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60 900w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60 1000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=60 1100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1200&q=60 1200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60 1296w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60 1400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=60 1600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1800&q=60 1800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2000&q=60 2000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2200&q=60 2200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2400&q=60 2400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2592&q=60 2592w',
              date: '21 Jun'));
      _commentController.text = '';
    }

    if (currentState is EpisodeDetailsStateRatingSuccess) {
      episode.previousRate = rating;
    }
    if (currentState is EpisodeDetailsStateLoveSuccess) {

      int likes = int.parse(episode.likesNumber);
      likes+=1;
      episode.likesNumber = likes.toString() ;
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    episodeId = ModalRoute.of(context).settings.arguments;
    screenWidth = MediaQuery.of(context).size.width;

    if (currentState is EpisodeDetailsStateInit) {
      widget._stateManager.getEpisodeDetails(episodeId);
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
            widget._stateManager.getEpisodeDetails(episodeId);
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
      drawer: widget._animeNavigationDrawer,
      body: Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child:
              /*loading?
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled:  true,

            child: body()
          ):*/
              body(),
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
//      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Widget body() {
    return Container(
      child: Column(children: [
        EpisodeDetailsWidget(
            name: episode.name,
            comments: episode.commentsNumber,
            likes: episode.likesNumber,
            rate: episode.rate,
            showYear: episode.showYear,
            image: episode.image,
            onLove: ()=> widget._stateManager.loveEpisode(episodeId),
        ),
        //rating the series
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).RateEpisode,
              style: TextStyle(fontSize: 14),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: AnimeRatingBar(
                rating: rating,
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
                  if(episode.previousRate == 0 ){
                    widget._stateManager.rateEpisode(episodeId, rating);
                    this.rating = rating;
                    setState(() {

                    });
                  }else{
                    Fluttertoast.showToast(msg:S.of(context).YouHaveRatedThisEpisode );
                  }


                },
                itemSize: 25,
                itemCount: 10,
              ),
            ),

//                RotatedBox(
//                  quarterTurns: 2,
//                  child: RatingBar(
//                  initialRating: 2,
//                  direction: Axis.horizontal,
//                  itemSize: 16,
////                allowHalfRating: true,
//                  itemCount: 10,
//                  ratingWidget: RatingWidget(
//                    full: RotatedBox(
//                        quarterTurns: 2,
//                        child: Icon(Icons.favorite,color: ProjectColors.ThemeColor,  )
//                    ),
////                  half: _image('assets/heart_half.png'),
//                    empty: RotatedBox(
//                      quarterTurns: 2,
//                        child: Icon(Icons.favorite_border,color: ProjectColors.ThemeColor, )
//                    ),
//                  ),
//                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                  onRatingUpdate: (rating) {
//                    print(rating);
//                  },
//              ),
//                ),
          ],
        ),

        //Statistics
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              S.of(context).statics,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10)
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).monthlyComments,
              style: TextStyle(
                  fontSize: 14,
                fontFamily:'Roboto',
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  fontFamily:'Roboto',
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),

        new AnimatedSize(
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
                    '${episode.about}',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily:'Roboto',
                    ),
                  ),
                )
//
                )),
        isExpanded
            ? new FlatButton(
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
            : new FlatButton(
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
                    fontSize: 18,
                    fontFamily:'Roboto',
                    fontWeight: FontWeight.bold
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
                  '${episode.classification}',
                  style: TextStyle(
                      fontFamily:'Roboto',
                      fontSize: 12
                  ),
                ))),
          ],
          //in case of multiple classifications
          /*  children: List.generate(anime.classification.length, (index) {
                  return Container(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                      margin: EdgeInsets.only(left:7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black38)
                      ),
                      child: Center(
                          child: RotatedBox(
                              quarterTurns: 2,
                              child: Text(
                                anime.classification[index],
                                style: TextStyle(
                                    fontSize: 10
                                ),
                              )
                          )
                      )
                  );
                }),*/
        ),

        //divider
        Container(
          margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
          height: 1,
          width: screenWidth * 0.8,
          color: Colors.black38,
        ),

        Container(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  S.of(context).LastReplaysAndComments,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily:'Roboto',
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            )),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: episode.comments.length,
          itemBuilder: (BuildContext context, int index) {
            return CommentCard(
              userImage:'${ episode.comments[index].userImage}',
              userName: '${ episode.comments[index].userName}',
              date: '${episode.comments[index].date}',
              likesNumber: episode.comments[index].likesNumber,
              comment: '${episode.comments[index].content}',
              onLove: ()=> widget._stateManager.loveComment(episode.comments[index].id),
            );
          },
        ),

        SizedBox(
          height: 60,
        )
      ]),
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
                          Text(
                              S.of(context).newInteraction,
                              style: TextStyle(
                                fontFamily:'Roboto',
                              )),
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
                            hintStyle: TextStyle(color: Colors.white),
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
                                      fontSize: 10,
                                      color: Colors.white,
                                    fontFamily:'Roboto',
                                  ),
                                ))
                          ],
                        ),
                      ),
                      FlatButton(
                          onPressed: () {
                            widget._stateManager.addComment(
                                _commentController.text.trim(),
                                episodeId,
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
                                      fontSize: 10,
                                      fontFamily:'Roboto',
                                      color: Colors.white
                                  ),
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