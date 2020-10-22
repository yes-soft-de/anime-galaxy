import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';
import 'package:anime_galaxy/module_anime/state/anime_details/anime_details.state.dart';
import 'package:anime_galaxy/module_anime/state_manager/anime_details/anime_details.state_manager.dart';
import 'package:anime_galaxy/module_anime/ui/widget/anime_details_widget/ainme_details_widget.dart';
import 'package:anime_galaxy/module_anime/ui/widget/comment_card/comment_card.dart';
import 'package:anime_galaxy/module_anime/ui/widget/episode_card/episode_card.dart';
import 'package:anime_galaxy/module_rating/ui/widget/rating_bar.dart';
import 'package:anime_galaxy/utils/project_colors/project_color.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inject/inject.dart';
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
  AnimeModel anime;
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
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    if (currentState is AnimeDetailsStateInit) {
      widget._stateManager.getAnimeDetails(3);
      if(this.mounted){
        setState(() {});
      }

    }
    return getPageLayout();



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
            widget._stateManager.getAnimeDetails(3);
          },
          child: Text(S.of(context).retry),
        )
      ],
    );
  }



  Widget getPageLayout(){
    return Scaffold(
      //TODO : replace the appbar with the proper one
      appBar : AppBar(title: Text('Anime'),),
      body : Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(

          child:loading?
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled:  true,

            child: body()
          ):
          body()
          ,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ProjectColors.ThemeColor,
        onPressed: (){},
        child:  Icon(
              Icons.comment,
            color: Colors.white,
          ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }


  Widget body(){
    return Column(
        children:[
          AnimeDetailsWidget(
              name: anime.name,
              comments: anime.commentsNumber,
              likes: anime.likesNumber,
              rate: anime.rate,
              showYear: anime.showYear,
              image : anime.image
          ),
          //rating the series
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimeRatingBar(
                rating: rating,
                fillIcon: Icon(Icons.favorite,color: ProjectColors.ThemeColor,  ),
                halfFillIcon: Icon(Icons.favorite_border,color: ProjectColors.ThemeColor,  ),
                emptyIcon: Icon(Icons.favorite_border,color: ProjectColors.ThemeColor, ),
                onRatingChanged: (rating) => setState(() => this.rating = rating),
                itemSize:40,
                itemCount: 10,
              ),
//                RatingBar(
//                initialRating: 2,
//                direction: Axis.horizontal,
//                itemSize: 30,
////                allowHalfRating: true,
//                itemCount: 5,
//                ratingWidget: RatingWidget(
//                  full: Icon(Icons.favorite,color: ProjectColors.ThemeColor,  ),
////                  half: _image('assets/heart_half.png'),
//                  empty: Icon(Icons.favorite_border,color: ProjectColors.ThemeColor, ),
//                ),
//                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                onRatingUpdate: (rating) {
//                  print(rating);
//                },
//              ),
              Text(
                S.of(context).RateSeries,
                style: TextStyle(
                    fontSize: 12
                ),
              )

            ],
          ),

          //about
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  S.of(context).About,
                  style: TextStyle(
                      fontSize: 12
                  ),
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
                  child:
                  Container(
                    width: screenWidth*0.9,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black38),

                    ),
                    child: Text(
                      anime.about,
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
                  S.of(context).More,
                  style: TextStyle(
                      fontSize: 10
                  ),
                ),
                Text(
                  S.of(context).Classification,
                  style: TextStyle(
                      fontSize: 10
                  ),
                ),
              ],
            ),
          ),

          //classifications
          RotatedBox(
            quarterTurns: 2,
            child: Row(
              children: [
                Container(
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
                              anime.classification,
                              style: TextStyle(
                              fontSize: 10
                              ),
                              )
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
                mainAxisAlignment: MainAxisAlignment.end,
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

            return  EpisodeCard(
              image: anime.episodes[index].image,
              episodeNumber: anime.episodes[index].episodeNumber,
              classification: anime.episodes[index].classification,
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
                mainAxisAlignment: MainAxisAlignment.end,
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
    );
  }

}
