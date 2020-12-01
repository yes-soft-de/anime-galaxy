import 'dart:io';

import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/main_screen/main_screen_routes.dart';
import 'package:anime_galaxy/module_init_account/init_account_routes.dart';
import 'package:anime_galaxy/module_profile/state_manager/edit_profile_state_manager/edit_profile_state_manager.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:anime_galaxy/module_upload/service/image_upload/image_upload_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inject/inject.dart';

@provide
class MyProfileScreen extends StatefulWidget {
  final EditProfileStateManager manager;
  final ImageUploadService imageUploadService;

  MyProfileScreen(this.manager, this.imageUploadService);

  @override
  State<StatefulWidget> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String _errorMsg;
  bool loading = false;
  String userImage;
  String userImageUrl ;

  @override
  void initState() {
    super.initState();
    widget.manager.stateStream.stream.listen((event) {
      // Null means no errors
      if (event == null) {
        Navigator.of(context).pushNamed(InitAccountRoutes.INIT_ACCOUNT_ROUTE);
      }
      if(event =='Cant create a profile') {
        _errorMsg = event;
        if (mounted) setState(() {});
      }else{
        userImageUrl = event;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String redirectTo = ModalRoute.of(context).settings.arguments.toString();
    redirectTo =
        redirectTo == null ? redirectTo : MainScreenRoute.MAIN_SCREEN_ROUTE;
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
          MediaQuery.of(context).viewInsets.bottom != 0 ? Container() : Container(
            height: 240,
            child: Stack(
              children: [
                 userImage == null
                    ? Positioned.fill(
                        child: Container(
                        color: Colors.orange,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              ImagePicker ip = ImagePicker();
                              ip
                                  .getImage(source: ImageSource.gallery)
                                  .then((value) {
                                if (value != null) {
                                  userImage = value.path;
//                                  widget.manager.saveProfileImage(value.path);
                                  print('lolo');
                                   widget.manager.uploadImage(userImage);
                                }
                              });
                            },
                            child: Text(
                              S.of(context).selectAnImage,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ))
                    : Positioned.fill(
                        child: Image.file(
                          File(userImage),
                          fit: BoxFit.cover,
                        ),
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: S.of(context).name,
                  hintText: S.of(context).name,
                ),
                keyboardType: TextInputType.text,
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
                  userImageUrl
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
