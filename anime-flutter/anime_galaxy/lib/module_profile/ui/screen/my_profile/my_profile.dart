import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_profile/profile_routes.dart';
import 'package:anime_galaxy/module_profile/state_manager/edit_profile_state_manager/edit_profile_state_manager.dart';
import 'package:anime_galaxy/module_theme/service/theme_service/theme_service.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';

@provide
class MyProfileScreen extends StatefulWidget {
  final EditProfileStateManager manager;

  MyProfileScreen(this.manager);

  @override
  State<StatefulWidget> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();

  String _errorMsg;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    widget.manager.stateStream.stream.listen((event) {
      // Null means no errors
      if (event == null) {
        Navigator.of(context).pushNamed(ProfileRoutes.ROUTE_PROFILE);
      } else {
        _errorMsg = event;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String redirectTo = ModalRoute.of(context).settings.arguments.toString();
    redirectTo = redirectTo == null ? redirectTo : ProfileRoutes.ROUTE_PROFILE;
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
          Flex(
            direction: Axis.vertical,
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Image.asset(
                      'assets/images/logo.jpg',
                      height: 120,
                    )
                  : Container(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: S.of(context).yourName,
                  hintText: S.of(context).nameHint,
                ),
                keyboardType: TextInputType.text,
                maxLines: 1,
                validator: (v) {
                  if (v.isEmpty) {
                    return S.of(context).pleaseInputPhoneNumber;
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
                if (_nameController.text.isEmpty) {
                  Fluttertoast.showToast(msg: S.of(context).nameIsEmpty);
                  return null;
                }
                if (_storyController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: S.of(context).pleaseTellUsAboutYourSelf);
                  return null;
                }

                loading = true;
                if (mounted) setState(() {});
                widget.manager.saveProfile(
                    _nameController.text.trim(), _storyController.text.trim());
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
