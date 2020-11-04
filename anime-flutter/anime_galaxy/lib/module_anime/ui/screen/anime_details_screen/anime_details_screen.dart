import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';
import 'package:anime_galaxy/module_anime/state/anime_details/anime_details.state.dart';
import 'package:anime_galaxy/module_anime/state_manager/anime_details/anime_details.state_manager.dart';
import 'package:anime_galaxy/module_anime/ui/widget/anime_details_widget/ainme_details_widget.dart';
import 'package:anime_galaxy/module_anime/ui/widget/comment_card/comment_card.dart';
import 'package:anime_galaxy/module_anime/ui/widget/episode_card/episode_card.dart';
import 'package:anime_galaxy/module_episode/episode_routes.dart';
import 'package:anime_galaxy/module_navigation/ui/widget/navigation_drawer/anime_navigation_drawer.dart';
import 'package:anime_galaxy/module_rating/ui/widget/rating_bar.dart';
import 'package:anime_galaxy/utils/app_bar/anime_galaxy_app_bar.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inject/inject.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

@provide
class AnimeDetailsScreen extends StatefulWidget {
  final AnimeDetailsStateManager _stateManager;

  AnimeDetailsScreen(this._stateManager);
  @override
  _AnimeDetailsScreenState createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> with TickerProviderStateMixin<AnimeDetailsScreen> {
  double screenWidth;
   bool isExpanded = false; 
  double rating = 3.5;
  bool  loading =true;
  AnimeDetailsState  currentState = AnimeDetailsStateInit();
  AnimeModel anime = new AnimeModel();
  bool isSwitched = false;
  int animeId ;
  final TextEditingController _commentController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  @override
  void initState() {

    super.initState();

    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent() {
    if (currentState is AnimeDetailsStateFetchingSuccess) {
      AnimeDetailsStateFetchingSuccess state = currentState;
      anime = state.data;
      loading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
    if (currentState is AnimeDetailsStateCommentingSuccess) {
      anime.comments.insert(0,
          new Comment(
              content: _commentController.text,
              //TODO : use logged in user information
              userName:'zoz',
              userImage:'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=60 200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=60 300w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60 400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60 500w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60 600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60 700w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60 800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60 900w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60 1000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=60 1100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1200&q=60 1200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60 1296w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60 1400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=60 1600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1800&q=60 1800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2000&q=60 2000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2200&q=60 2200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2400&q=60 2400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2592&q=60 2592w' ,
              date: '21 Jun'
          )
      ) ;
      _commentController.text='';

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
  }

  @override
  Widget build(BuildContext context) {
    animeId = ModalRoute.of(context).settings.arguments;
    screenWidth = MediaQuery.of(context).size.width;

    if (currentState is AnimeDetailsStateInit) {
      widget._stateManager.getAnimeDetails(animeId);
      if(this.mounted){
        setState(() {});
      }

    }
    return loading?
            LoadingIndicatorWidget():
            getPageLayout();



//    switch (currentState.runtimeType) {
//      case AnimeDetailsStateInit:
//        {
//          widget._stateManager.getAnimeDetails(1);
//          return getPageLayout();
//        }
//        break;
//      case AnimeDetailsStateFetchingSuccess:
//        return getPageLayout();
//        break;
//      case AnimeDetailsStateFetchingError:{
//        loading = false;
//        return setErrorUI();
//      }
//
//        break;
//
//      default:
//        return Container();
//    }


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



  Widget getPageLayout(){
    return Scaffold(
      key: _scaffoldKey,
      appBar : AnimeGalaxyAppBar.getAnimeGalaxyAppBar( _scaffoldKey),
      drawer: AnimeNavigationDrawer(),
      body : Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(

          child:/*loading?
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled:  true,

            child: body()
          ):*/
          body()
          ,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ProjectColors.ThemeColor,

        onPressed: (){
          _showCommentDialog(context);
        },
        child:  Icon(
              Icons.comment,
            color: Colors.white,
          ),

      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }


  Widget body(){
    return Container(
      child: Column(
          children:[
            AnimeDetailsWidget(
                name: anime.name,
                comments: anime.commentsNumber,
                likes: anime.likesNumber,
                rate: anime.rate,
                showYear: anime.showYear,
                image : anime.image,
                isFollowed : anime.isFollowed,
                onFollow:()=>  widget._stateManager.addToFavourite(animeId,anime.categoryID),
            ),
            //rating the series
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).RateSeries,
                  style: TextStyle(
                      fontSize: 14
                  ),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: AnimeRatingBar(
                    rating: rating,
                    fillIcon: Icon(Icons.favorite,color: ProjectColors.ThemeColor,  ),
                    halfFillIcon: Icon(Icons.favorite_border,color: ProjectColors.ThemeColor,  ),
                    emptyIcon: Icon(Icons.favorite_border,color: ProjectColors.ThemeColor, ),
                    onRatingChanged: (rating) => setState(() => this.rating = rating),
                    itemSize:25,
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
                Text(S.of(context).statics),
                SizedBox(width: 10,)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  S.of(context).generalEvaluation,
                  style: TextStyle(
                      fontSize: 14
                  ),
                ),
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width *0.5,
                  animation: true,
                  lineHeight: 12.0,
                  animationDuration: 1500,
                  percent: 0.8 ,
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
                      fontSize: 14
                  ),
                ),
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width *0.5,
                  animation: true,
                  lineHeight: 12.0,
                  animationDuration: 1500,
                  percent: 0.8 ,
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
                        fontSize: 12
                    ),
                  ),
                  SizedBox(width: 10,)
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
                    child:
                    Container(
                      width: screenWidth*0.9,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black38),

                      ),
                      child: Text(
                        '${anime.about}',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    )
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

            //divider
            Container(
              margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              height: 1,
              width: screenWidth*0.8,
              color: Colors.black38,
            ),
            Container(
              margin: EdgeInsetsDirectional.fromSTEB(10,0,10,20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    S.of(context).Classification,
                    style: TextStyle(
                        fontSize: 10
                    ),
                  ),
                  Text(
                    S.of(context).More,
                    style: TextStyle(
                        fontSize: 10
                    ),
                  ),

                ],
              ),
            ),

            //classifications
              Row(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                    margin: EdgeInsets.only(left:7),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black38)
                  ),
                      child: Center(
                           child: Text(
                                '${anime.classification}',
                                style: TextStyle(
                                fontSize: 10
                                ),
                                )
                      )
                  ),
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
              width: screenWidth*0.8,
              color: Colors.black38,
            ),

            Container(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).LastEpisodes,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 12
                      ),
                    ),
                  ],
                )
            ),
            // last episodes
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index){

              return  GestureDetector(
                onTap: ()=> Navigator.pushNamed(
                    context,
                    EpisodeRoutes.ROUTE_EPISODE_DETAILS_SCREEN,
                    arguments:anime.episodes[index].id
                ),
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
                  childAspectRatio: (2.3/4)
              ),
              itemCount:anime.episodes.length,

              shrinkWrap: true,),

            Container(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).LastReplaysAndComments,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 12
                      ),
                    ),
                  ],
                )
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: anime.comments.length,
              itemBuilder: (BuildContext context , int index){
                return  CommentCard(
                  userImage: anime.comments[index].userImage,
                  userName: anime.comments[index].userName,
                  date: anime.comments[index].date,
                  comment: anime.comments[index].content,
                );
              },
            ),



            SizedBox(height: 60,)
          ]
      ),
    );

  }
  void  _showCommentDialog(BuildContext context) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
      // here we use a nested StatefulWidget builder so that the dialog can
      // micromanage it's own state
      return StatefulBuilder(
          builder: (context, setState) {
            return  SimpleDialog(

              children: [
                Container(
                  padding:EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              S.of(context).newInteraction,
                              style: GoogleFonts.roboto(

                              )
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Colors.black,
                        ),
                        width: MediaQuery.of(context).size.width*0.6,
                        child: TextField(
                          controller: _commentController ,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                          ),
                          maxLines: 8,
                          decoration: InputDecoration.collapsed(
                            hintText:S.of(context).addYourComment,
                            hintStyle: TextStyle( color: Colors.white),
                          ),

                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black
                        ),
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Switch(
                              value: isSwitched,
                              onChanged: ( isOn) {
                                setState(() {
                                  isSwitched = !isSwitched;
                                });
                              },
                              activeTrackColor: ProjectColors.ThemeColor,
                              activeColor: Colors.white,
                            ),
                            Text(
                                S.of(context).spoilerAlert,
                                style: GoogleFonts.roboto(
                                  textStyle : TextStyle(
                                      fontSize: 10,
                                      color: Colors.white
                                  ),
                                )
                            )
                          ],
                        ),
                      ),


                      FlatButton(
                          onPressed: (){
                            widget._stateManager.addComment(_commentController.text.trim(), animeId, isSwitched);
                            Navigator.pop(context, true);
                          },

                          child:Container(

                            height: 30,
                            width: MediaQuery.of(context).size.width*0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ProjectColors.ThemeColor,
                            ),
                            child: Text(
                                S.of(context).sendComment,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  textStyle : TextStyle(
                                      fontSize: 10,
                                      color: Colors.white
                                  ),
                                )
                            ),

                          )
                      ),
                    ],
                  ),
                )
              ],
            );
          }
      );

        }




    );
  }
}
