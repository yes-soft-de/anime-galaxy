import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_init_account/init_account_routes.dart';
import 'package:anime_galaxy/module_profile/presistance/profile_shared_preferences.dart';
import 'package:anime_galaxy/module_profile/state_manager/edit_profile_state_manager/edit_profile_state_manager.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:anime_galaxy/module_upload/service/image_upload/image_upload_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inject/inject.dart';

@provide
class MyProfileScreen extends StatefulWidget {
  final EditProfileStateManager manager;
  final ImageUploadService imageUploadService;
  final ProfileSharedPreferencesHelper _profileSharedPreferencesHelper;

  MyProfileScreen(
    this.manager,
    this.imageUploadService,
    this._profileSharedPreferencesHelper,
  );

  @override
  State<StatefulWidget> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
      final TextEditingController _storyController = TextEditingController() ;
      final TextEditingController _nameController = TextEditingController() ;

  String _errorMsg;
  bool loading = false;
  String userImage;
  String userCoverImage;

  String userImageUrl;

  String initialName;
  String initialStory;

  String redirectTo = InitAccountRoutes.INIT_ACCOUNT_ROUTE;

  @override
  void initState() {
    super.initState();
    setInitialValues();

    widget.manager.stateStream.stream.listen((event) {
      // Null means no errors
      if (event == null) {
        Navigator.of(context).pushReplacementNamed(redirectTo);
      }
      if (event == 'Cant create a profile') {
        _errorMsg = event;
        if (mounted) setState(() {});
      } else {
        userImageUrl = event;
      }
    });
  }

  void setInitialValues() async {

    initialName = await widget._profileSharedPreferencesHelper.getUsername();
    initialStory = await widget._profileSharedPreferencesHelper.getUserStory();

    _nameController.text = initialName;
    _storyController.text = initialStory;
  }

  @override
  Widget build(BuildContext context) {
    String link = ModalRoute.of(context).settings.arguments;
    if (link != null) redirectTo = link;


    return Scaffold(
      body: _getProfileEditScreen(),
    );
  }

  Widget _getProfileEditScreen() {
    return Form(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(),
          MediaQuery.of(context).viewInsets.bottom != 0
              ? Container()
              : Container(
                  height: 240,
                  child: Stack(
                    children: [
                      /*userImage == null
                          ?*/ Positioned.fill(
                              child: Container(
                              color: Colors.orange,
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                      color: Colors.red,
                                      border: Border(

                                      )
                                    ),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child:   Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              ImagePicker ip = ImagePicker();
                                              ip
                                                  .getImage(source: ImageSource.gallery)
                                                  .then((value) {
                                                if (value != null) {
                                                  userImage = value.path;
                                                  print('image picked');
                                                  setState(() {

                                                  });
//                                  widget.manager.saveProfileImage(value.path);

                                                  // widget.manager.uploadImage(userImage);
                                                }
                                              });
                                            },
                                            child: userImage==null?
                                            Text(
                                              S.of(context).selectAnImage,
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 14),
                                            ):
                                            Icon(Icons.check_circle,size: 25, color: Colors.white,)
                                            ,
                                          ),
                                        ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        ImagePicker ip = ImagePicker();
                                        ip
                                            .getImage(source: ImageSource.gallery)
                                            .then((value) {
                                          if (value != null) {
                                            userCoverImage = value.path;
                                            print('cover image picked');
                                            setState(() {

                                            });
//                                  widget.manager.saveProfileImage(value.path);

                                            // widget.manager.uploadImage(userImage);
                                          }
                                        });
                                      },
                                      child: userCoverImage == null ? Text(
                                        'اختر صورة الغلاف',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ):
                                      Icon(Icons.check_circle,size: 30,color: Colors.white,),
                                    ),
                                  ),
                                ],
                              )
                            ))
                          /*: Positioned.fill(
                              child: Image.file(
                                File(userImage),
                                fit: BoxFit.cover,
                              ),
                            ),*/
                    ],
                  ),
                ),
//          Row(
//            children: [
//              Expanded(
//                child: Container(
//                  height: 150,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
//                    image: DecorationImage(
//                        image: NetworkImage(
//                            'https://i.pinimg.com/236x/ec/e4/b0/ece4b097f87bd6a79d8e05cfd45d17d6--matte-painting-digital-paintings.jpg'),
//                        fit: BoxFit.cover),
//                  ),
//                  child:  Container(
//                          decoration: BoxDecoration(
//                            borderRadius:
//                            BorderRadius.all(Radius.circular(3.0)),
//                            color: Colors.black.withOpacity(0.25),
//                          ),
//                          child: Align(
//                              alignment: Alignment.center,
//                              child: GestureDetector(
//                                child: CircularImage(
//                                  width: 100,
//                                  height: 100,
//                                  linkImg:  'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w',
//                                ),
//                              )),
//                        )
//
//                ),
//              )
//            ],
//          ),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: S.of(context).name,
                  hintText: S.of(context).name,
                ),
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value)=> _nameController.text = value,
                validator: (v) {
                  if (v.isEmpty) {
                    return S.of(context).pleaseProvideYourName;
                  }
                  return null;
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
                controller: _storyController,
                decoration: InputDecoration(
                  labelText: S.of(context).aboutMe,
                  hintText: S.of(context).aboutMe,
                ),
                maxLines: 3,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (String value){
                    _storyController.text = value.trim();

                },
                validator: (v) {
                  if (v.isEmpty) {
                    return S.of(context).pleaseInputPhoneNumber;
                  }
                  return null;
                }),
          ),
          _errorMsg != null ? Text(_errorMsg) : Container(),
          Container(
            height: 50,
            decoration: BoxDecoration(color: ProjectColors.ThemeColor),
            child: GestureDetector(
              onTap: () {
                if (_storyController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: S.of(context).pleaseTellUsAboutYourSelf);
                  return null;
                }


                loading = true;
                if (mounted) setState(() {});
                widget.manager.saveProfile(
                    _nameController.text.trim(),
                    _storyController.text.trim(),
                    userImage,
                    userCoverImage,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      loading == false
                          ? S.of(context).saveProfile
                          : S.of(context).loading,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
