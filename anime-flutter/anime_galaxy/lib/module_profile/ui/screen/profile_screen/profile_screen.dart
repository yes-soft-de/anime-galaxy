import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/main_screen/main_screen_routes.dart';
import 'package:anime_galaxy/module_anime/anime_routes.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_profile/model/profile_model/profile_model.dart';
import 'package:anime_galaxy/module_profile/presistance/profile_shared_preferences.dart';
import 'package:anime_galaxy/module_profile/state/my_profile_state.dart';
import 'package:anime_galaxy/module_profile/state_manager/my_profile/my_profile_state_manager.dart';
import 'package:anime_galaxy/module_profile/ui/widget/activity_card/activity_card.dart';
import 'package:anime_galaxy/module_profile/ui/widget/comment_card/comment_card.dart';
import 'package:anime_galaxy/module_profile/ui/widget/personal_info_widget/personal_info_widget.dart';
import 'package:anime_galaxy/module_profile/ui/widget/series_card/card_series.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inject/inject.dart';


@provide
class ProfileScreen extends StatefulWidget {
  final AuthService _authService;
  final MyProfileStateManager _stateManager;
  final ProfileSharedPreferencesHelper _preferencesHelper;

  ProfileScreen(
      this._authService,
      this._stateManager,
      this._preferencesHelper,
      );

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool hasProfile = false;
  bool loading = true;
  ProfileModel _profileModel;
  MyProfileState currentState = MyProfileStateInit();
  String userId;

  @override
  void initState() {
    super.initState();

    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent() {
    if (currentState is ProfileFetchingDataSuccess) {
      ProfileFetchingDataSuccess state = currentState;
      _profileModel = state.data;
      loading = false;
    }
    if (currentState is ProfileFollowSuccess) {
      _profileModel.isFollowed = true;
      int num = int.parse( _profileModel.followingNumber);
      num+=1;
      _profileModel.followingNumber =num.toString() ;
    }
    if (currentState is ProfileUnFollowSuccess) {
      int num = int.parse( _profileModel.followingNumber);
      num-=1;
      _profileModel.isFollowed = false;

    }
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    userId = ModalRoute.of(context).settings.arguments;

    if (currentState is MyProfileStateInit) {
      (userId == null)
          ? widget._stateManager.getMyProfile()
          : widget._stateManager.getMyProfile(userId: userId);

      if (this.mounted) {
        setState(() {});
      }
    }

    return loading ? LoadingIndicatorWidget() : newPageLayout();
  }

  Widget pageLayout() {
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(7, 10, 7, 10),
              child: Column(
                children: [
                  //personal info
                  PersonalInfoWidget(
                    image: _profileModel.image,
                    name: _profileModel.name,
                    createDate: _profileModel.createDate,
                    //TODO : change it
                    category: '',
                    commentsNumber: _profileModel.commentsNumber,
                    followingNumber: _profileModel.followingNumber,
                    seriesNumber: _profileModel.seriesNumber.toString(),
                  ),

                  if (userId != null)
                    FlatButton(
                      color: _profileModel.isFollowed
                          ? Colors.grey
                          : ProjectColors.ThemeColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
                      onPressed: () => _profileModel.isFollowed
                          ? widget._stateManager.unFollow(userId)
                          : widget._stateManager.follow(userId),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Center(
                          child: Text(
                            _profileModel.isFollowed
                                ? S.of(context).unFollow
                                : S.of(context).Follow,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily:'Roboto',
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  //about me
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).aboutMe,
                        style: TextStyle(
                            fontFamily:'Roboto',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      '${_profileModel.about}',
                      style: TextStyle(
                        fontFamily:'Roboto',
                      ),
                    ),
                  ),


                  //activities
                  //display following activities only for me
                  if( userId == null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).activities,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily:'Roboto',
                          ),
                        ),
                      ],
                    ),

                  if ( userId == null)
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _profileModel.followingActivities.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: ActivityCard(
                              date:  _profileModel.followingActivities[index].date,
                              userName:
                              _profileModel.followingActivities[index].userName,
                              userImage:  _profileModel.followingActivities[index].userImage,
                              activity:
                              _profileModel.followingActivities[index].action,
                            ),
                          );
                        }) ,

                  SizedBox(
                    height: 20,
                  ),
                  //watched series
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).watchedSeries,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily:'Roboto',
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 225,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: _profileModel.watchedSeries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
                                arguments: _profileModel.watchedSeries[index].id),
                            child: SeriesCard(
                              url_image: _profileModel.watchedSeries[index].image,
                              series_category: 'شونين',
                              series_name: _profileModel.watchedSeries[index].name,
                            ),
                          );
                        }),
                  ),

                  //previous comments
                  if ( userId != null)
                    previousCommentSection(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget newPageLayout(){
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(

              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              _profileModel.cover
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 175,
                    //profile image
                    child: Container(
                      alignment: Alignment(0.0,2.5),
                      child: CircleAvatar(
                        radius: 53.0,

                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              _profileModel.image??
                                  'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d'
                          ),
                          radius: 51.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'انضم '+ _profileModel.createDate,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily:'Roboto',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        _profileModel.name??'',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily:'Roboto',
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black26,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Column(
                                  children: [
                                    Text(
                                      S.of(context).following,
                                      style: TextStyle(
                                        fontFamily:'Roboto',
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      _profileModel.followingNumber??'0',
                                      style: TextStyle(
                                        fontFamily:'Roboto',
                                        color: ProjectColors.ThemeColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black26,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      S.of(context).series,
                                      style: TextStyle(
                                        fontFamily:'Roboto',
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      _profileModel.seriesNumber.toString()??'0',
                                      style: TextStyle(
                                        fontFamily:'Roboto',
                                        color: ProjectColors.ThemeColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Text(
                                      S.of(context).comments,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily:'Roboto',
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      _profileModel.commentsNumber??'0',
                                      style: TextStyle(
                                        fontFamily:'Roboto',
                                        color: ProjectColors.ThemeColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10,),

                              ],
                            ),
                          ),
                        ],
                      ),

                      if (userId != null)
                        FlatButton(
                          color: _profileModel.isFollowed
                              ? Colors.grey
                              : ProjectColors.ThemeColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          onPressed: () => _profileModel.isFollowed
                              ? widget._stateManager.unFollow(userId)
                              : widget._stateManager.follow(userId),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Center(
                              child: Text(
                                _profileModel.isFollowed
                                    ? S.of(context).unFollow
                                    : S.of(context).Follow,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily:'Roboto',
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      //about me

                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.grey[400],Colors.white],
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).aboutMe,
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
                        margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          '${_profileModel.about}',
                          style: TextStyle(
                            fontFamily:'Roboto',
                          ),
                        ),
                      ),


                      //activities
                      //display following activities only for me
                      if( userId == null)
                        Container(
                          margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.grey[400],Colors.white],
                              )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).activities,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),



                      if ( userId == null)
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _profileModel.followingActivities.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: ActivityCard(
                                  date:  _profileModel.followingActivities[index].date,
                                  userName:
                                  _profileModel.followingActivities[index].userName,
                                  userImage:  _profileModel.followingActivities[index].userImage,
                                  activity:
                                  _profileModel.followingActivities[index].action,
                                ),
                              );
                            }) ,

                      SizedBox(
                        height: 20,
                      ),
                      //watched series
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.grey[400],Colors.white],
                            )
                        ),
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
                          ],
                        ),
                      ),

                      Container(
                        height: 225,
                        color: Colors.grey[300],
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _profileModel.watchedSeries.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
                                    arguments: _profileModel.watchedSeries[index].id),
                                child: SeriesCard(
                                  url_image: _profileModel.watchedSeries[index].image,
                                  series_category: 'شونين',
                                  series_name: _profileModel.watchedSeries[index].name,
                                ),
                              );
                            }),
                      ),

                      //previous comments
                      if ( userId != null)
                        previousCommentSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }


  Widget previousCommentSection(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              S.of(context).previousComments,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily:'Roboto',
              ),
            ),
          ],
        ),

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _profileModel.previousComments.commentsOnAnime.length,
            itemBuilder:(BuildContext context , int index){
              return CommentCard(
                userName: _profileModel.name,
                userImage: _profileModel.image,
                comment:_profileModel.previousComments.commentsOnAnime[index].comment ,
                commmentOn: 'على المسلسل :' + _profileModel.previousComments.commentsOnAnime[index].animeName   ,
              );
            }
        ),

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _profileModel.previousComments.commentsOnEpisodes.length,
            itemBuilder:(BuildContext context , int index){
              return CommentCard(
                userName: _profileModel.name,
                userImage: _profileModel.image,
                comment:_profileModel.previousComments.commentsOnEpisodes[index].comment ,
                commmentOn:'على المسلسل : '+
                    _profileModel.previousComments.commentsOnEpisodes[index].animeName+
                    ' الحلقة رقم: '+
                    _profileModel.previousComments.commentsOnEpisodes[index].episodeNumber.toString() ,
              );
            }
        ),
      ],
    );
  }
}
