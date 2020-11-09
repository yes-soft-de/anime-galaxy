import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_profile/model/profile_model/profile_model.dart';
import 'package:anime_galaxy/module_profile/ui/widget/activity_card/activity_card.dart';
import 'package:anime_galaxy/module_profile/ui/widget/personal_info_widget/personal_info_widget.dart';
import 'package:anime_galaxy/module_profile/ui/widget/series_card/card_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_profile/presistance/profile_shared_preferences.dart';
import 'package:anime_galaxy/module_profile/service/my_profile/my_profile.dart';

@provide
class ProfileScreen extends StatefulWidget {
  final AuthService _authService;
  final MyProfileService _myProfileService;
  final ProfileSharedPreferencesHelper _preferencesHelper;

  ProfileScreen(
    this._authService,
    this._myProfileService,
    this._preferencesHelper,
  );

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool hasProfile = false;
  bool loading = true;
  ProfileModel _profileModel;

  @override
  void initState() {
    super.initState();
    // Listent to Events Here
  }

  @override
  Widget build(BuildContext context) {
    return pageLayout();
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
                        onFollow: (){},
                        image: 'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w',
                        name: 'محمد',
                        category: 'شونين-فانتازي',
                        isFollowed: false,
                        commentsNumber: '122',
                        followingNumber: '75',
                        seriesNumber: '10',
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
                        'fffffffffffffffffffffffffffffffffffffffffffffffff',
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
                    itemCount:5/* _profileModel.followingActivities.length*/,
                    itemBuilder:(BuildContext context,int index){
                      return   Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ActivityCard(
                          date: 'منذ ساعتين',
                          userName: 'علي موسى',
                          userImage: '',
                          activity: 'دكتور ستون',
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
                        itemCount: 5 /*_profileModel.watchedSeries.length*/,
                        itemBuilder: (BuildContext context , int index){
                          return   SeriesCard(
                              url_image: 'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w',
                              series_category: 'شونين',
                              series_name: 'دكتور ستون',
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
