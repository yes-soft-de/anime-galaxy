import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_anime/anime_routes.dart';
import 'package:anime_galaxy/module_profile/model/profile_model/profile_model.dart';
import 'package:anime_galaxy/module_profile/state/my_profile_state.dart';
import 'package:anime_galaxy/module_profile/state_manager/my_profile/my_profile_state_manager.dart';
import 'package:anime_galaxy/module_profile/ui/widget/activity_card/activity_card.dart';
import 'package:anime_galaxy/module_profile/ui/widget/personal_info_widget/personal_info_widget.dart';
import 'package:anime_galaxy/module_profile/ui/widget/series_card/card_series.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_profile/presistance/profile_shared_preferences.dart';
import 'package:anime_galaxy/module_profile/service/my_profile/my_profile.dart';

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
  String userId ;

  @override
  void initState() {
    super.initState();

    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }

  void processEvent() {
    if (currentState is ProfileFetchingDataSuccess ) {
      ProfileFetchingDataSuccess state = currentState;
      _profileModel = state.data;
      loading = false;
      if (this.mounted) {
        setState(() {});
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    userId = ModalRoute.of(context).settings.arguments;

    if (currentState is MyProfileStateInit) {
      (userId == null) ?
          widget._stateManager.getMyProfile() :
          widget._stateManager.getMyProfile(userId: userId) ;

      if(this.mounted){
        setState(() {});
      }
    }



    return loading?
            LoadingIndicatorWidget():
            pageLayout();

  }



  Widget pageLayout(){
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
                        //TODO : change it
                        category: 'شونين-فانتازي',
                        //TODO : change it when it available at backend
                        commentsNumber: '200',
                        followingNumber: _profileModel.followingNumber.toString(),
                        seriesNumber: _profileModel.seriesNumber.toString(),
                      ),
                  //about me
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          S.of(context).aboutMe,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    ],
                  ),
                   Container(
                     margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                     width: MediaQuery.of(context).size.width*0.8,
                     child: Text(
                        '${_profileModel.about}',
                      ),
                   ),
                 //activities
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).activities,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),

                    ],
                  ),

                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _profileModel.followingActivities.length,
                    itemBuilder:(BuildContext context,int index){
                      return   Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ActivityCard(
                          //TODO : change it
                          date: 'منذ ساعتين',
                          userName: _profileModel.followingActivities[index].userName,
                          //TODO : change it when it available at backend
                          userImage: '',
                          activity: _profileModel.followingActivities[index].action,
                        ),
                      );
                      } ),

                  SizedBox(height: 20,),
                  //watched series
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).watchedSeries,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
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
                        itemBuilder: (BuildContext context , int index){
                          return   GestureDetector(
                            onTap: ()=> Navigator.pushNamed(
                                context,
                                AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN,
                                arguments: _profileModel.watchedSeries[index].id
                            ),
                            child: SeriesCard(
                                url_image:_profileModel.watchedSeries[index].image  ,
                              //TODO : change it when it available at backend
                                series_category: 'شونين',
                                series_name:_profileModel.watchedSeries[index].name ,
                            ),
                          );
                        }
                        ),
                  ),

                ],
            ),
          ),
        ),
      )
    );
  }


}